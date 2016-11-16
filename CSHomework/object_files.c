#include "object_files.h"

int file_check (FILE *file, char *filename) {
	file = fopen(filename, 'r');
	if(!file) {
		printf("File Not Found\n");
		return -1;
	}
	return 0;
}

int flip_endian (int word) {
	word first = word & 0xFF00;
	word second = word & 0x00FF;
	return second | first;
}

int read_object_file (char *filename, machine_state *state) {
	FILE* f;
	int check = file_check(f, filename);
	if(check == -1) {
		return -1;
	}
	int wordVal = getWord(f);
}

int getWord(FILE* file) {
	char* word[4];
	for(int i = 0; i < 4; i++) {
		char in = fgetc(f);
		if((in >= 48 && in <= 57) || (in >= 97 && in <= 102)) {
			word[i] = in;
		}
		else {
			i--;
		}
	}
	int val = readWord(word);
	val = flip_endian(val);
	return val;
}

int readWord (char* in) {
	char* input = tolower(in);
	word result;
	for(int i = 0; i < sizeof(in); i++) {
		if(input[i] < 97) {
			result += (atoi(input[i]) * exp(16, i));
		}
		if(input[i] == 97) {
			result += (10 * exp(16, i));
		}
		if(input[i] == 98) {
			result += (11 * exp(16, i));
		}
		if(input[i] == 99) {
			result += (12 * exp(16, i));
		}
		if(input[i] == 100) {
			result += (13 * exp(16, i));
		}
		if(input[i] == 101) {
			result += (14 * exp(16, i));
		}
		if(input[i] == 102) {
			result += (15 * exp(16, i));
		}
	}
	return result;
}