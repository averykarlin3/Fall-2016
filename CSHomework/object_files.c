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
	int wordVal = getWord(f, FULL_WORD);
	while(wordVal != -1) {
		if(wordVal == 0xCADE || wordVal == 0xDADA) {
			if(TRACE_OFF) {
				if(wordVal == 0xCADE) {
					printf("Code:\n");
				}
				else {
					printf("Data:\n");
				}
			}
			wordVal = getWord(f, FULL_WORD);
			currentLoc = wordVal;
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				word inst = getWord(f, FULL_WORD);
				(state->memory)[currentLoc] = inst;
				if(TRACE_OFF && inst) {
					printf("Memory Address: %x = %x\n", currentLoc, inst);
				}
				currentLoc++;
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0xC3B7) {
			getWord(f, FULL_WORD);
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0xF17E) {
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
			wordVal = getWord(f, FULL_WORD);
			continue;
		}
		if(wordVal == 0x715E) {
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
	int word[size/2];
	for(int i = 0; i < size/2; i++) {
		int in = fgetc(file);
		if(in == EOF) {
			return -1;
		}
		word[i] = in;
	}
	int val = word[0] + word[1]*16*16;
	val = flip_endian(val);
	return val;
}