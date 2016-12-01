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
	fprintf(output, ".ADDR 0x0\n.CODE\nCONST R5 0xFF\nHICONST R5 0x7F\nADD R6 R5 #0\n");
	while(1) {
		token* next = (token*) malloc(sizeof(token));
		int retToken = read_token(next, input);
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
				fprintf(output, "BRzp ZERO\n");
			}
			if(!strcmp(next->str, "le")) {
				fprintf(output, "BRp ZERO\n");
			}
			if(!strcmp(next->str, "eq")) {
				fprintf(output, "BRnp ZERO\n");
			}
			if(!strcmp(next->str, "ge")) {
				fprintf(output, "BRn ZERO\n");
			}
			if(!strcmp(next->str, "gt")) {
				fprintf(output, "BRnz ZERO\n");
			}
			fprintf(output, "CONST R2 #1\nJMP AFTERZ\nZERO CONST R2 #0\n");
			fprintf(output, "AFTERZ STR R2 R6 #2\nADD R6 R6 #1\n");
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
			char c;
			while(c != '\n') {
				c = getc(input);
			}
		}
		//INCLUDE IF, ARG, AND FUNCTION
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