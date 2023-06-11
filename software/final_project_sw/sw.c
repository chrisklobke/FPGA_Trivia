/*
 * cnt_sw.c
 *
 *  Created on: Oct 16, 2022
 *      Author: klobkec
 *
 *      Lab 4 - NIOS
 *
 *      This program ouputs "Hello World!" to the console
 *      and a counter on to a seven segment output
 *      and the representation of the switches inputs to the second seven segment display
 */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "altera_avalon_pio_regs.h"
#include "altera_up_avalon_video_character_buffer_with_dma.h"
#include "system.h"
#include <string.h>
#include <stdbool.h>

//Question has a question, a level, one correct answer and 3 incorrect answers
struct Question {
	char *question;
	int level;
	char *answerCorrect;
	char *answer1;
	char *answer2;
	char *answer3;
} Question;

//Margin for Question and answers
int xMargin = 10;
int yMargin = 10;

//Amount of questions
int n = 15;
//Array of questions
struct Question questions[15];
struct Question q;

//Array for 4 answers
char* answers[] = { "", "", "", ""};

//Returns a random Question based on a level input
struct Question getRandomQuestionByLevel(int level) {
	//Shuffle the question array
	shuffleQuestions();
	//Get the first quesiton with the desired level
	for (int i = 0; i < n; i++) {
		if (questions[i].level == level) {
			return questions[i];
		}
	}
}

int main() {
	alt_u8 key; //To store the current key input
	alt_u8 key_mem; //To store an old key input
	alt_u8 level;
	alt_u8 old_level;
	alt_u8 answer;
	alt_u8 cnt;
	int time_cnt; //Counter to simulate a delay
	int SSEGvalue1; //For the chosen answer output to the SSEG
	int SSEGvalue2; //For the correct answer output to the SSEG
	alt_u8 ready = 1; //Helps to prevent two answer logins back to back
	alt_up_char_buffer_dev * char_buf_dev;
	char_buf_dev = alt_up_char_buffer_open_dev("/dev/video_character_buffer_with_dma_0");

	fillQuestions();
	printf ("Program started \n");
	//Initialize some variables
	cnt = 0;
	time_cnt = 0;
	SSEGvalue1 = 0b00000000;
	SSEGvalue2 = 0b0000000000000000;

	//Endless loop
	while(1) {
		//Store current key input
		key = IORD_ALTERA_AVALON_PIO_DATA(PIO_INPUT_KEY_BASE);

		//Store current level, returned from the FSM
		level = IORD_ALTERA_AVALON_PIO_DATA(PIO_INPUT_LEVEL_BASE);

		//If current level is not start or end
		if (level != 0 && level != 6) {
			//Highlight the chosen answer, based on key input
			highlightAnswer(key, char_buf_dev);
			//Reset SSEG for chosen answer
			SSEGvalue1 = 0b00000000;
		}

		//If no key is pushed
		if (key == 0b0000) {
			//Ready for next answer
			ready = 1;
			//Reset delay counter
			time_cnt = 0;
		}

		//Default answer to 00
		//That way if no answer is given, the FSM won't change the state
		answer = 0b00;

		//If ready to receive the next answer input
		if (ready == 1) {
			//If level 0/idle state (no question asked yet, on screen: "Press any button")
			if (level == 0b0000) {
				//If any key is pressed
				if (key != 0b0000) {
					//Go to next state (question state)
					answer = 0b11;
				}
			}
			//If level 6/winning state
			else if (level == 0b0110) {
				//Store "answered but incorrect" for FSM
				answer = 0b10;
			}
			//If any other level and a key is pressed
			else if (key != 0b0000){
				//Remember old key value
				key_mem = key;
				//Highlight the current chosen answer
				highlightAnswer(key, char_buf_dev);
				//Store chosen answer for SSEG output
				SSEGvalue1 = getSSEG1value(q, key_mem);
				//Increase delay counter
				time_cnt++;
				//If enough time has passed
				if (time_cnt >= 30000) {
					//Reset correct answer value for SSEG
					SSEGvalue2 = 0b0000000000000000;
					//If chosen answers is correct
					if (answers[key2index(key)] == q.answerCorrect) {
						//Store "answered and correct" for FSM
						answer = 0b11;
					}
					//If answered but incorrect
					else {
						//Store "answered but incorrect" for FSM
						answer = 0b10;
						//Return answer to FSM
						IOWR_ALTERA_AVALON_PIO_DATA(PIO_OUTPUT_ANSWER_BASE, answer);
						//Highlight the correct and incorrect answer
						highlighCorrecttAnswer(key, char_buf_dev);
						//Wait
						usleep(1000000);
					}
					//Store correct answer for SSEG
					SSEGvalue2 = getSSEG2value(q);
				}
				//Output correct and chosen answer to SSEG
				IOWR_ALTERA_AVALON_PIO_DATA(PIO_SSEG_BASE, SSEGvalue1 + SSEGvalue2);
			}
		}

		//If level has changed or first run
		if (level != old_level || cnt == 0) {
			//If level 1 get level 1 question
			if (level == 0b0001) {
				q = getRandomQuestionByLevel(1);
			}
			//If level 2 get level 2 question
			else if (level == 0b0010) {
				q = getRandomQuestionByLevel(2);
			}
			//If level 3 get level 3 question
			else if (level == 0b0011) {
				q = getRandomQuestionByLevel(3);
			}
			//If level 4 get level 4 question
			else if (level == 0b0100) {
				q = getRandomQuestionByLevel(4);
			}
			//If level 5 get level 5 question
			else if (level == 0b0101) {
				q = getRandomQuestionByLevel(5);
			}

			//If idle state
			if (level == 0) {
				//Show title with "Press any key.."
				displayTitle("Press any key to start the game.", char_buf_dev);
			}
			//If winning state
			else if (level == 6) {
				//Show title with "You win"
				displayTitle("You win!!!", char_buf_dev);
			}
			//If other state
			else {
				//Display question and answers
				displayQuestion(q, char_buf_dev, true);
				//Display the level and indicate which one the player is in
				displayLevel(level, char_buf_dev);
				//Display the 'boxes' around the answer and question
				//(has to be done here bc other display functions clear buffer)
				displayBoxes(char_buf_dev);
			}
			//Store old level
			old_level = level;
			//Not ready bc key pushed
			ready = 0;
			//Reset delay counter
			time_cnt = 0;
			cnt++;
		}

		//Output answer to FSM
		IOWR_ALTERA_AVALON_PIO_DATA(PIO_OUTPUT_ANSWER_BASE, answer);
	}

	return 0;
}

//Fills the question array
void fillQuestions() {
	q.question = "What does the Analysis and Elaboration do?";
	q.level = 1;
	q.answerCorrect = "Creates RTL";
	q.answer1 = "Creates Logic";
	q.answer2 = "Assign/view pins";
	q.answer3 = "Check syntax errors";
	questions[0] = (q);

	q.question = "What does RTL stand for?";
	q.level = 1;
	q.answerCorrect = "Register Transfer Level";
	q.answer1 = "Real Time Logic";
	q.answer2 = "Read Trunk Link";
	q.answer3 = "Route Through Line";
	questions[1] = (q);

	q.question = "How many bits are needed for 10 values?";
	q.level = 1;
	q.answerCorrect = "4";
	q.answer1 = "5";
	q.answer2 = "6";
	q.answer3 = "3";
	questions[2] = (q);

	q.question = "How many kB can be stored in an MK9 block?";
	q.level = 2;
	q.answerCorrect = "9";
	q.answer1 = "5";
	q.answer2 = "6";
	q.answer3 = "3";
	questions[3] = (q);

	q.question = "Which of the following is a state machine type?";
	q.level = 2;
	q.answerCorrect = "Moore";
	q.answer1 = "Milly";
	q.answer2 = "Morse";
	q.answer3 = "Michael";
	questions[4] = (q);

	q.question = "What is the minimum sample rate for Nyquist?";
	q.level = 2;
	q.answerCorrect = "2 x f_in";
	q.answer1 = "2/f_in";
	q.answer2 = "f_in/2";
	q.answer3 = "2^f_in";
	questions[5] = (q);

	q.question = "What does LAB stand for?";
	q.level = 3;
	q.answerCorrect = "Logic Array Block";
	q.answer1 = "Logic Array Bridge";
	q.answer2 = "Low Amp Block";
	q.answer3 = "Little as Big";
	questions[6] = (q);

	q.question = "Which of the following is not part of a PLL?";
	q.level = 3;
	q.answerCorrect = "Clock Divider";
	q.answer1 = "Charge Pump";
	q.answer2 = "Low Pass Filter";
	q.answer3 = "Phase Detector";
	questions[7] = (q);

	q.question = "How do you calculate the output frequency of a PLL?";
	q.level = 3;
	q.answerCorrect = "f_in x M/N";
	q.answer1 = "f_in x N/M";
	q.answer2 = "M/f_in x N";
	q.answer3 = "M^f_in - N";
	questions[8] = (q);

	q.question = "What is not correct about pointers?";
	q.level = 4;
	q.answerCorrect = "Are case sensitive";
	q.answer1 = "Have no type";
	q.answer2 = "Point to any type";
	q.answer3 = "Can be casted";
	questions[9] = (q);

	q.question = "In which file can you find base addresses?";
	q.level = 4;
	q.answerCorrect = "system.h";
	q.answer1 = "linker.h";
	q.answer2 = "nios2.h";
	q.answer3 = ".._pio_regs.h";
	questions[10] = (q);

	q.question = "In which file can you find IO read and write functions?";
	q.level = 4;
	q.answerCorrect = ".._pio_regs.h";
	q.answer1 = "linker.h";
	q.answer2 = "nios2.h";
	q.answer3 = "system.h";
	questions[11] = (q);

	q.question = "What is not correct about the accelerometor?";
	q.level = 5;
	q.answerCorrect = "5 wire SPI";
	q.answer1 = "Triggers on int1";
	q.answer2 = "10 bit wide";
	q.answer3 = "+/- 2g range";
	questions[12] = (q);

	q.question = "What is the correct order of the blocks of a PLL?";
	q.level = 5;
	q.answerCorrect = "Error Det., LPF, VCO";
	q.answer1 = "LPF, VCO, Error Det.";
	q.answer2 = "Error Det., VCO, LPF";
	q.answer3 = "VCO, Error Det. LPF";
	questions[13] = (q);

	q.question = "Who is the VHDL god?";
	q.level = 5;
	q.answerCorrect = "Dr. Johnson";
	q.answer1 = "Stephen Hawking";
	q.answer2 = "Dr. Stecklina";
	q.answer3 = "Angela Merkel";
	questions[14] = (q);
}

//Shuffles the question array randomly
void shuffleQuestions() {
	if (n > 1) {
        size_t i;
        for (i = 0; i < n - 1; i++)
        {
          size_t j = i + rand() / (RAND_MAX / (n - i) + 1);
          struct Question t = questions[j];
          questions[j] = questions[i];
          questions[i] = t;
        }
   }
}

//Shuffles the answer array randomly
void shuffleAnswers()
{
    int size = 4;
    if (size > 1)
    {
        int i;
        for (i = 0; i < size - 1; i++)
        {
            int j = rand() % size; //Random number between 0 and 3
            const char* temp = answers[j];
            answers[j] = answers[i];
            answers[i] = temp;
        }
    }
}

//Displays the margins of the question and answers to make it look better
void displayBoxes(alt_up_char_buffer_dev *char_buf_dev) {
	//Draw a line under the question from the left to right
	for (int i = -2; i < 56; i++) {
		alt_up_char_buffer_string(char_buf_dev, "_", xMargin+i ,yMargin + 1);
	}

	//Draw lines next to Answer A
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 9);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 10);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 11);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 9);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 10);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 11);

	//Draw lines next to Answer B
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 19);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 20);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin-2 ,yMargin + 21);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 19);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 20);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin+25 ,yMargin + 21);

	//Draw lines next to Answer C
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 9);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 10);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 11);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 9);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 10);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 11);

	//Draw lines next to Answer D
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 19);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 20);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 28 ,yMargin + 21);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 19);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 20);
	alt_up_char_buffer_string(char_buf_dev, "|", xMargin + 55 ,yMargin + 21);
}

//Returns a value the SSEG can interpret, based on a key input
int getSSEG1value(struct Question q, int key) {
	int value;
	if (key == 0b0001) {
		value = 0b10001000;
	}
	else if (key == 0b0010) {
		value = 0b10000011;
	}
	else if (key == 0b0100) {
		value = 0b11000110;
	}
	else if (key == 0b1000) {
		value = 0b10100001;
	}
	else {
		value = 0b00000000;
	}
	return value;
}

//Returns a value the SSEG can interpret, based on a key input
int getSSEG2value(struct Question q) {
	int value;
	if (answers[0] == q.answerCorrect) {
		value = 0b1000100000000000;
	}
	else if (answers[1] == q.answerCorrect) {
		value = 0b1000001100000000;
	}
	else if (answers[2] == q.answerCorrect) {
		value = 0b1100011000000000;
	}
	else if (answers[3] == q.answerCorrect) {
		value = 0b1010000100000000;
	}
	else {
		value = 0b0000000000000000;
	}
	return value;
}

//Displays a title, nearly in the center of the screen
void displayTitle(char* text, alt_up_char_buffer_dev *char_buf_dev) {
	alt_up_char_buffer_clear(char_buf_dev);
	alt_up_char_buffer_string(char_buf_dev, text, xMargin + 17 ,yMargin + 15);
}

//Displays the levels on the right side of the screen and highlights the current one
void displayLevel(int level, alt_up_char_buffer_dev *char_buf_dev) {
	//Display all levels
	alt_up_char_buffer_string(char_buf_dev, "Level 1", xMargin + 60,yMargin + 20);
	alt_up_char_buffer_string(char_buf_dev, "Level 2", xMargin + 60,yMargin + 15);
	alt_up_char_buffer_string(char_buf_dev, "Level 3", xMargin + 60,yMargin + 10);
	alt_up_char_buffer_string(char_buf_dev, "Level 4", xMargin + 60,yMargin + 5);
	alt_up_char_buffer_string(char_buf_dev, "Level 5", xMargin + 60,yMargin);

	//If current level is 1, highlight level 1
	if (level == 1) {
		alt_up_char_buffer_string(char_buf_dev, "->", xMargin + 58 ,yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin);
	}
	//If current level is 2, highlight level 2
	else if (level == 2) {
		alt_up_char_buffer_string(char_buf_dev, "->", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin);
	}
	//If current level is 3, highlight level 3
	else if (level == 3) {
		alt_up_char_buffer_string(char_buf_dev, "->", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin);
	}
	//If current level is 4, highlight level 4
	else if (level == 4) {
		alt_up_char_buffer_string(char_buf_dev, "->", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin);
	}
	//If current level is 5, highlight level 5
	else if (level == 5) {
		alt_up_char_buffer_string(char_buf_dev, "->", xMargin + 58 ,yMargin);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 20);
	}
	//If no current level, clear all indicators
	else {
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 15);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 5);
		alt_up_char_buffer_string(char_buf_dev, "  ", xMargin + 58 ,yMargin + 20);
	}
}

//Highlights an answer by drawing an O next to it
void highlightAnswer(int key, alt_up_char_buffer_dev *char_buf_dev) {
	//If no key pressed, clear all indicators
	if (key == 0b0000) {
		alt_up_char_buffer_string(char_buf_dev, " ", xMargin-1 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, " ", xMargin + 30 -1 ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, " ", xMargin-1 ,yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, " ", xMargin + 30 -1 ,yMargin + 20);
	}
	//Highlight question A
	else if (key == 0b0001) {
		alt_up_char_buffer_string(char_buf_dev, "O", xMargin-1 ,yMargin + 10);
	}
	//Highlight question B
	else if (key == 0b0010) {
		alt_up_char_buffer_string(char_buf_dev, "O", xMargin + 30 -1 ,yMargin + 10);
	}
	//Highlight question C
	else if (key == 0b0100) {
		alt_up_char_buffer_string(char_buf_dev, "O", xMargin-1 ,yMargin + 20);
	}
	//Highlight question D
	else if (key == 0b1000) {
		alt_up_char_buffer_string(char_buf_dev, "O", xMargin + 30 -1 ,yMargin + 20);
	}
}

//Highlights the correct answer, and marks chosen answers as incorrect
void highlighCorrecttAnswer(int key, alt_up_char_buffer_dev *char_buf_dev) {
	//Go through all answers
	for (int i = 0; i < 4; i++) {
		//If correct one is found
		if (answers[i] == q.answerCorrect) {
			//If index is 0, highlight A
			if (i == 0) {
				alt_up_char_buffer_string(char_buf_dev, "O", xMargin-1 ,yMargin + 10);
			}
			//If index is 1, highlight B
			else if (i == 1) {
				alt_up_char_buffer_string(char_buf_dev, "O", xMargin + 30 -1 ,yMargin + 10);
			}
			//If index is 2, highlight C
			else if (i == 2) {
				alt_up_char_buffer_string(char_buf_dev, "O", xMargin-1 ,yMargin + 20);
			}
			//If index is 3, highlight D
			else if (i == 3) {
				alt_up_char_buffer_string(char_buf_dev, "O", xMargin + 30 -1 ,yMargin + 20);
			}
		}
	}

	//If chosen answer is A
	if (key == 0b0001) {
		alt_up_char_buffer_string(char_buf_dev, "X", xMargin-1 ,yMargin + 10);
	}
	//If chosen answer is B
	else if (key == 0b0010) {
		alt_up_char_buffer_string(char_buf_dev, "X", xMargin + 30 -1 ,yMargin + 10);
	}
	//If chosen answer is C
	else if (key == 0b0100) {
		alt_up_char_buffer_string(char_buf_dev, "X", xMargin-1 ,yMargin + 20);
	}
	//If chosen answer is D
	else if (key == 0b1000) {
		alt_up_char_buffer_string(char_buf_dev, "X", xMargin + 30 -1 ,yMargin + 20);
	}
}

//Displays the questions and answers
void displayQuestion(struct Question q, alt_up_char_buffer_dev *char_buf_dev, bool showAnswers ) {
	//Fill answers array with answers of current question
	answers[0] = q.answer1;
	answers[1] = q.answer2;
	answers[2] = q.answer3;
	answers[3] = q.answerCorrect;

	//Shuffle answers
	shuffleAnswers();

	printf("%s\n", q.question);

	//Clear buffer
	alt_up_char_buffer_clear(char_buf_dev);

	//If answers are supposed to be shown
	if (showAnswers) {
		printf("A: %s\n", answers[0]);
		printf("B: %s\n", answers[1]);
		printf("C: %s\n", answers[2]);
		printf("D: %s\n", answers[3]);

		//Display answers
		alt_up_char_buffer_string(char_buf_dev, "A.", xMargin ,yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "B.", xMargin + 30, yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, "C.", xMargin, yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, "D.", xMargin + 30, yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, answers[0], xMargin + 3, yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, answers[1], xMargin + 33, yMargin + 10);
		alt_up_char_buffer_string(char_buf_dev, answers[2], xMargin + 3, yMargin + 20);
		alt_up_char_buffer_string(char_buf_dev, answers[3], xMargin + 33, yMargin + 20);
	}

	//Display question
	alt_up_char_buffer_string(char_buf_dev, q.question, xMargin - 2, yMargin);
}

//Returns an index of the answer array based on the key input
int key2index(int key) {
	int index = -1;

	if (key == 0b0001)
		index = 0;
	else if (key == 0b0010)
		index = 1;
	else if (key == 0b0100)
		index = 2;
	else if (key == 0b1000)
		index = 3;

	return index;
}



