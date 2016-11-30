#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main() {
	char file[100];
	printf("Enter filename: ");
	scanf(" %s", file);
	FILE* f = fopen(file, "r");
	char fileText[200];
	fgets(fileText, 200, f);
	int frequency[26];
	for(int i = 0; i < 26; i++)
		frequency[i] = 0;
	for(int i = 0; i < 200; i++) {
		if(fileText[i] == '\n') {
			break;
		}
		char c = toupper(fileText[i]);
		if(c < 65 || c > 90) {
			continue;
		}
		(frequency[c - 65])++;
	}
	char maxChar = 0;
	int maxNum = 0;
	for(int i = 0; i < 26; i++) {
		if(frequency[i] >= maxNum) {
			maxChar = i + 65;
			maxNum = frequency[i];
		}
	}
	printf("Letter: %c\n", tolower(maxChar));
}