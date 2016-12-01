#include "jc.h"

int main(int argc, char* argv[]) {
	if(argc < 2) {
		printf("Execution Error - Not Enough Inputs\n");
		return -1;
	}
	FILE* input = fopen(argv[1], "w");
	if(output == NULL) {
		printf("Runtime Error - File Unable to be Opened\n");
		return -2;
	}
	while(1) {
		token* next = (token*) malloc(sizeof(token));
		int retToken = read_token(next, input);
		if(next->type == 0) {

		}
		//Deal with token
		if(retToken == 1) {
			break;
		}
		if(retToken == 2) {
			printf("Runtime Error - Faulty Token\n");
			break;
		}
	}
}