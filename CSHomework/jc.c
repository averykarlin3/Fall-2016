#include "jc.h"

int main(int argc, char* argv[]) {
	if(argc < 2) {
		printf("Execution Error - Not Enough Inputs\n");
		return -1;
	}
	FILE* input = fopen(argv[1], "r");
	if(input == NULL) {
		printf("Runtime Error - Input File Unable to be Opened\n");
		return -2;
	}
	int fileLen = strlen(argv[1]);
	char outputName[fileLen + 3];
	memcpy(outputName, argv[1], fileLen - 1);
	strcat(outputName, "asm");
	FILE* output = fopen(outputName, "w");
	if(input == NULL) {
		printf("Runtime Error - Output File Unable to be Opened\n");
		return -3;
	}
	fprintf(output, ".ADDR 0x0\n.CODE\nCONST R5 0x00\nHICONST R5 0x80\nADD R6 R5 #-1\nJMP MAIN\n");
	while(1) {
		token* next = (token*) malloc(sizeof(token));
		int retToken = read_token(next, input);
		printf("%s\n", next->str);
		if(next->type == 0) {
			int p1 = next->literal_value & 0xFF;
			int p2 = (next->literal_value >> 8) & 0xFF;
			fprintf(output, "CONST R0 %X\nHICONST R0 %X\nSTR R0 R6 #0\nADD R6 R6 #-1\n", p1, p2);
		}
		if(next->type == 1) {
			fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\n");
			if(!strcmp(next->str, "+")) {
				fprintf(output, "ADD R0 R0 R1\n");
			}
			if(!strcmp(next->str, "-")) {
				fprintf(output, "SUB R0 R0 R1\n");
			}
			if(!strcmp(next->str, "*")) {
				fprintf(output, "MUL R0 R0 R1\n");
			}
			if(!strcmp(next->str, "/")) {
				fprintf(output, "DIV R0 R0 R1\n");
			}
			fprintf(output, "STR R0 R6 #2\nADD R6 R6 #1\n");
		}
		if(next->type == 2) {
			fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nCMP R0 R1\n");
			if(!strcmp(next->str, "lt")) {
				fprintf(output, "BRzp ZERO%i\n", compCount);
			}
			if(!strcmp(next->str, "le")) {
				fprintf(output, "BRp ZERO%i\n", compCount);
			}
			if(!strcmp(next->str, "eq")) {
				fprintf(output, "BRnp ZERO%i\n", compCount);
			}
			if(!strcmp(next->str, "ge")) {
				fprintf(output, "BRn ZERO%i\n", compCount);
			}
			if(!strcmp(next->str, "gt")) {
				fprintf(output, "BRnz ZERO%i\n", compCount);
			}
			fprintf(output, "CONST R2 #1\nJMP AFTERZ%i\nZERO%i CONST R2 #0\n", compCount, compCount);
			fprintf(output, "AFTERZ%i STR R2 R6 #2\nADD R6 R6 #1\n", compCount);
			compCount++;
		}
		if(next->type == 3) {
			if(!strcmp(next->str, "and")) {
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nAND R0 R0 R1\n");
			}
			if(!strcmp(next->str, "or")) {
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nOR R0 R0 R1\n");
			}
			if(!strcmp(next->str, "not")) {
				fprintf(output, "LDR R0 R6 #1\nNOT R0 R0\n");
			}
			fprintf(output, "STR R0 R6 #2\nADD R6 R6 #1\n");
		}
		if(next->type == 4) {
			if(!strcmp(next->str, "drop")) {
				fprintf(output, "ADD R6 R6 #1\n");
			}
			if(!strcmp(next->str, "dup")) {
				fprintf(output, "LDR R0 R6 #1\nSTR R0 R6 #-1\nADD R6 R6 #-1\n");
			}
			if(!strcmp(next->str, "swap")) {
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nSTR R1 R6 #1\nSTR R0 R6 #2\n");
			}
			if(!strcmp(next->str, "max")) {
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\n");
			}
		}
		if(next->type == 7) {
			char c = 0;
			while(c != '\n') {
				c = getc(input);
			}
		}
		if(next->type == 5) {
			int len = strlen(next->str);
			int val = atoi(&((next->str)[3]));
			fprintf(output, "ADD R0 R5 #%i\nLDR R0 R0 #0\nSTR R0 R6 #0\nADD R6 R6 #1\n", -val-2);
		}
		if(next->type == 6) {
			if(!strcmp(next->str, "if")) {
				condLoop* oldIf = currentIf;
				currentIf = (condLoop*) malloc(sizeof(condLoop));
				currentIf->prev = oldIf;
				currentIf->elseFound = 0;
				if(oldIf) {
					currentIf->ifLayer = (oldIf->ifLayer)++;
				}
				else {
					currentIf->ifLayer = 1;
				}
				fprintf(output, "LDR R0 R6 #1\nBRz NOT%i\n", currentIf->ifLayer);
			}
			if(!strcmp(next->str, "else")) {
				currentIf->elseFound = 1;
				fprintf(output, "BR ENDIF%i\nNOT%i\n", currentIf->ifLayer, currentIf->ifLayer);
			}
			if(!strcmp(next->str, "endif")) {
				if(currentIf->elseFound) {
					fprintf(output, "ENDIF%i\n", currentIf->ifLayer);
				}
				else {
					fprintf(output, "NOT%i\n", currentIf->ifLayer);
				}
				condLoop* oldIf = currentIf->prev;
				free(currentIf);
				currentIf = oldIf;
			}
		}
		if(next->type == 8) {
			if(!strcmp(next->str, "defun")) {
				fprintf(output, ".FALIGN\n");
				retToken = read_token(next, input);
				printf("%i\n", retToken);
				printf("%s\n", next->str);
				fprintf(output, "%s\n", next->str);
			}
			if(!strcmp(next->str, "return")) {
				fprintf(output, "LDR R0 R6 #1\nSTR R0 R5 #2\nLDR R7 R5 #1\nADD R6 R5 #1\nLDR R5 R5 #0\n");
				fprintf(output, "JMPR R7\n");
			}
		}
		if(next->type == -1) {
			fprintf(output, "JSR %s\nSTR R7 R6 #-1\nSTR R5 R6 #-2\nADD R6 R6 #-3\n", next->str);
		}
		if(retToken == 1) {
			break;
		}
		if(retToken == 2) {
			printf("Runtime Error - Faulty Token\n");
			break;
		}
	}
	printf("File Compiling Completed\n");
}


//STACK FOR PRIMARY FUNCITON
//CHECK FOR ITEMS IN THE STACK//ELSE IF ISSUES//FUNCTION ERROR

//NEWSTACK -> CFP -> RA -> RV -> STACK