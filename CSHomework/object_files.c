#include "object_files.h"

int file_check (FILE *file, char *filename) {
	file = fopen(filename, "r");
	if(!file) {
		printf("File Not Found\n");
		return -1;
	}
	return 0;
}

int flip_endian (int w) {
	word first = w & 0xFF00;
	word second = w & 0x00FF;
	return second | first;
}

int read_object_file (char *filename, machine_state *state) {
	printf("%s\n", filename);
	FILE* f;
	printf("Dos\n");
	int check = file_check(f, filename);
	printf("Here\n");
	if(check == -1) {
		return -1;
	}
	printf("arrived\n");
	int wordVal = getWord(f, FULL_WORD);
	printf("%i\n", wordVal);
	word currentLoc;
	int remainingStream;
	while(wordVal != -1) {
		printf("hereNow\n");
		if(wordVal == 0xCADE || wordVal == 0xDADA) {
			wordVal = getWord(f, FULL_WORD);
			currentLoc = wordVal;
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				(state->memory)[currentLoc] = getWord(f, FULL_WORD);
				currentLoc++;
			}
		}
		if(wordVal == 0xC3B7) {
			getWord(f, FULL_WORD);
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
		}
		if(wordVal == 0xF17E) {
			wordVal = getWord(f, FULL_WORD);
			remainingStream = wordVal;
			for(int i = 0; i < remainingStream; i++) {
				getWord(f, HALF_WORD);
			}
		}
		if(wordVal == 0x715E) {
			getWord(f, FULL_WORD);
			getWord(f, FULL_WORD);
			getWord(f, FULL_WORD);
		}
		return -2;
	}
	return 0;
}

int getWord(FILE* file, int size) {
	char word[size];
	for(int i = 0; i < size; i++) {
		printf("%p\n", file);
		int in = fgetc(file);
		printf("fuck%i\n", in);
		if((in >= 48 && in <= 57) || (in >= 97 && in <= 102)) {
			word[i] = (char) in;
			continue;
		}
		if(in == EOF) {
			return -1;
		}	
		i--;
	}
	int val = readWord(word);
	val = flip_endian(val);
	return val;
}

int readWord (char* in) {
	word result;
	for(int i = 0; i < sizeof(in); i++) {
		if(tolower(in[i]) < 97) {
			result += ((in[i] - 48) * pow(16, i));
		}
		if(tolower(in[i]) == 97) {
			result += (10 * pow(16, i));
		}
		if(tolower(in[i]) == 98) {
			result += (11 * pow(16, i));
		}
		if(tolower(in[i]) == 99) {
			result += (12 * pow(16, i));
		}
		if(tolower(in[i]) == 100) {
			result += (13 * pow(16, i));
		}
		if(tolower(in[i]) == 101) {
			result += (14 * pow(16, i));
		}
		if(tolower(in[i]) == 102) {
			result += (15 * pow(16, i));
		}
	}
	return result;
}

/*int main() {
	machine_state* m = (machine_state*) malloc(sizeof(machine_state));
	reset(m);
	read_object_file("./testcases/public-test_basic.obj", m);
}*/

//ADD SYMBOLIC FUNCTIONALITY