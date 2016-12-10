#include "token.h"

int read_token (token *theToken, FILE *theFile) {
	char strTok[MAX_TOKEN_LENGTH];
	fscanf(theFile, " %s", strTok);
	int isNumber = 1; //1 == decimal, 2 == hex
	int end = feof(theFile);
	theToken->type = 0;
	if(end) {
		end = 1;
	}
	int len = strlen(strTok);
	for(int i = 0; i < len; i++) {
		if(strTok[i+1] == '0' && strTok[i+2] == 'x' && strTok[i] == '-' && i == 0 && len >= 4) {
			isNumber = 2;
			i += 2;
			continue;
		}
		if(strTok[i] == '0' && strTok[i+1] == 'x' && i == 0) {
			isNumber = 2;
			i += 1;
			continue;
		}
		if(strTok[i] == '-' && i == 0 && len >= 2) {
			continue;
		}
		if(!isdigit(strTok[i]) && isNumber != 2) {
			isNumber = 0;
			break;
		}
		char c = tolower(strTok[i]);
		if(isNumber == 2 && !isdigit(strTok[i]) && c != 'a' && c != 'b' && c != 'c' && c != 'd' && c != 'e' && c != 'f') {
			isNumber = 0;
			break;
		}
	}
	if(isNumber == 1) {
		theToken->type = -2;
		strcpy(theToken->str, strTok);
		sscanf(strTok, "%i", &(theToken->literal_value));
		return end;
	}
	if(isNumber == 2) {
		theToken->type = -2;
		sscanf(strTok, "%x", &(theToken->literal_value));
		return end;
	}
	if(!strcmp(strTok, "+") || !strcmp(strTok, "-") || !strcmp(strTok, "*") || !strcmp(strTok, "/") || !strcmp(strTok, "\%")) {
		theToken->type = 1;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(!strcmp(strTok, "lt") || !strcmp(strTok, "le") || !strcmp(strTok, "eq") || !strcmp(strTok, "ge") || !strcmp(strTok, "gt")) {
		theToken->type = 2;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(!strcmp(strTok, "and") || !strcmp(strTok, "or") || !strcmp(strTok, "not")) {
		theToken->type = 3;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(!strcmp(strTok, "drop") || !strcmp(strTok, "dup") || !strcmp(strTok, "swap") || !strcmp(strTok, "max") || !strcmp(strTok, "low8")) {
		theToken->type = 4;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(len >= 4) {
		char trio[3];
		memcpy(trio, strTok, 3);
		if(!strcmp(trio, "arg")) {
			theToken->type = 5;
			strcpy(theToken->str, strTok);
			return end;
		}
	}
	if(!strcmp(strTok, "if") || !strcmp(strTok, "else") || !strcmp(strTok, "endif")) {
		theToken->type = 6;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(strTok[0] == ';') {
		theToken->type = 7;
		strcpy(theToken->str, strTok);
		return end;
	}
	if(!strcmp(strTok, "defun") || !strcmp(strTok, "return")) {
		theToken->type = 8;
		strcpy(theToken->str, strTok);
		return end;
	}
	int tokLen = strlen(strTok);
	int isFunc = 1;
	for(int i = 0; i < tokLen; i++) {
		char c = strTok[i];
		if(c == '_' || isalnum(c)) {
			continue;
		}
		isFunc = 0;
	}
	if(isFunc) {
		theToken->type = -1;
		strcpy(theToken->str, strTok);
		return end;
	}
	return 2;
}