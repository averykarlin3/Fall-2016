#include "object_files.h"

FILE* file_check (FILE *file, char *filename) {
	file = fopen(filename, "r");
	if(!file) {
		printf("File Not Found\n");
	}
	return file;
}

int flip_endian (int w) {
	word first = (w & 0xFF00) >> 8;
	word second = (w & 0x00FF) << 8;
	return second | first;
}

int read_object_file (char *filename, machine_state *state) {
	FILE* f;
	f = file_check(f, filename);
	if(f == NULL) {
		return -1;
	}
	word currentLoc;
	int remainingStream;
	int dataStore; //Check if storing data, such that only nonzero commands are recorded in milestone
	int wordVal = getWord(f, FULL_WORD);
	while(wordVal != -1) {
		dataStore = 0;
		if(wordVal == 0xCADE || wordVal == 0xDADA) { //Code or Data block
			if(TRACE_OFF) {
				if(wordVal == 0xCADE) {
					printf("Code:\n");
				}
				else {
					printf("Data:\n");
					dataStore = 1;
				}
			}
			wordVal = getWord(f, FULL_WORD); //Get block information
			currentLoc = wordVal;
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) { //Memory value stream
				word inst = getWord(f, FULL_WORD);
				(state->memory)[currentLoc] = inst;
				if(TRACE_OFF && (inst || dataStore)) { //Milestone printing
					printf("Memory Address: %x = %x\n", currentLoc, inst);
				}
				currentLoc++;
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0xC3B7) { //Skip symbol  block
			getWord(f, FULL_WORD);
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0xF17E) { //Skip file name block
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0x715E) { //Skip line number block
			getWord(f, FULL_WORD);
			getWord(f, FULL_WORD);
			getWord(f, FULL_WORD);
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		return -2;
	}
	return 0;
}

int getWord(FILE* file, int size) {
	int word[size/2]; //Get sequence of hex values from file of length size/2
	for(int i = 0; i < size/2; i++) {
		int in = fgetc(file);
		if(in == EOF) {
			return -1;
		}
		word[i] = in;
	}
	int val = 0; //Convert big-endian array of hex values to single little-endian value
	for(int i = 0; i < size/2; i++) {
		val += word[i] * pow(16, 2*i);
	}
	val = flip_endian(val);
	return val;
}