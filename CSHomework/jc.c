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
	FILE* output = fopen("output.asm", "w");
	if(input == NULL) {
		printf("Runtime Error - Output File Unable to be Opened\n");
		return -3;
	}
	fprintf(output, ".ADDR 0x0\n.CODE\nCONST R5 0x00\nHICONST R5 0x80\nADD R6 R5 #-1\n");
	functLen += 3;
	while(1) {
		token* next = (token*) malloc(sizeof(token));
		int retToken = read_token(next, input);
		if(next->type == 0) {
			functLen += 4;
			int p1 = next->literal_value & 0xFF;
			int p2 = (next->literal_value >> 8) & 0xFF;
			fprintf(output, "CONST R0 %X\nHICONST R0 %X\nSTR R0 R6 #0\nADD R6 R6 #-1\n", p1, p2);
		}
		if(next->type == 1) {
			functLen += 5;
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
			functLen += 9;
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
				functLen += 5;
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nAND R0 R0 R1\n");
			}
			if(!strcmp(next->str, "or")) {
				functLen += 5;
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nOR R0 R0 R1\n");
			}
			if(!strcmp(next->str, "not")) {
				functLen += 4;
				fprintf(output, "LDR R0 R6 #1\nNOT R0 R0\n");
			}
			fprintf(output, "STR R0 R6 #2\nADD R6 R6 #1\n");
		}
		if(next->type == 4) {
			if(!strcmp(next->str, "drop")) {
				functLen += 1;
				fprintf(output, "ADD R6 R6 #1\n");
			}
			if(!strcmp(next->str, "dup")) {
				functLen += 3;
				fprintf(output, "LDR R0 R6 #1\nSTR R0 R6 #-1\nADD R6 R6 #-1\n");
			}
			if(!strcmp(next->str, "swap")) {
				functLen += 4;
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\nSTR R1 R6 #1\nSTR R0 R6 #2\n");
			}
			if(!strcmp(next->str, "max")) {
				functLen += 2;
				fprintf(output, "LDR R0 R6 #1\nLDR R1 R6 #2\n");
			}
		}
		if(next->type == 7) {
			char c;
			while(c != '\n') {
				c = getc(input);
			}
		}
		if(next->type == 5) {
			functLen += 4;
			int len = strlen(next->str);
			int val = atoi((next->str)[3]);
			fprintf(output, "ADD R0 R5 #%i\nLDR R0 R0 #0\nSTR R0 R6 #0\nADD R6 R6 #1\n", -val-2);
		}
		if(next->type == 6) {
			if(!strcmp(next->str, "if")) {
				functLen += 2;
				condLoop* oldIf = currentIf;
				currentIf = (condLoop*) malloc(sizeof(condLoop));
				currentIf->prev = oldIf;
				currentIf->elseFound = 0;
				currentIf->ifLayer = (oldIf->ifLayer)++;
				fprintf(output, "LDR R0 R6 #1\nBRz NOT%i\n", ifLayer);
			}
			if(!strcmp(next->str, "else")) {
				functLen += 2;
				currentIf->elseFound = 1;
				fprintf(output, "BR ENDIF%i\nNOT%i\n", ifLayer, ifLayer);
			}
			if(!strcmp(next->str, "endif")) {
				functLen += 1;
				if(currentIf->elseFound) {
					fprintf(output, "ENDIF%i\n", ifLayer);
				}
				else {
					fprintf(output, "NOT%i\n", ifLayer);
				}
				condLoop* oldIf = currentIf->prev;
				free(currentIf);
				currentIf = oldIf;
			}
		}
		if(next->type == 8) {
			if(!strcmp(next->str, "defun")) {
				functLast += functLen;
				functLen = 0;
				fprintf(output, ".ADDR 0x%X\n", functNext);
				//ADD FUNCTION NAME
			}
			if(!strcmp(next->str, "return")) {
				functLen++;
				fprintf(output, "RET\n.ADDR 0x%X\n", functLast);
				functNext += functLen;
				functLen = 0;
			}
		}
		//ADD FUNCTION CALLS
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