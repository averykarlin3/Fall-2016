/*
 * CIS 240 HW 9: LC4 Simulator
 * trace.c 
 */

#include "object_files.h"

int main(int argc, char *argv[]) {
	if(argc < 3) {
		printf("Input Error - Not Enough Inputs\n");
		return -3;
	}
	outbin = fopen(argv[1], "w"); //If output file cannot be opened
	if(!outbin) {
		printf("Write Error - File Unable to be Written\n");
		return -4;
	}
	outpbm = fopen(strcat(argv[1], ".ppm"), "w"); //If output file cannot be opened
	if(!outpbm) {
		printf("Write Error - Image File Unable to be Written\n");
		return -6;
	}
	machine_state* state = (machine_state*) malloc(sizeof(machine_state));
	reset(state);
	for(int i = 2; i < argc; i++) { //Read files in order of command line inputs
		int read = read_object_file(argv[i], state);
		if(read == -1) { //If file can't be opened
			printf("Read Error - File %s Not Found\n", argv[i]);
			free(state);
			return read;
		}
		if(read == -2) { //If object file hex blocks are invalid
			printf("Read Error - Object File %s Block Corrupt\n", argv[i]);
			free(state);
			return read;
		}
	}
	while(state->PC != 0x80FF && !TRACE_OFF) { //If full trace software
		int ret = update_state(state);
		if(ret == 1) { //Exception 1
			printf("PC %X: Runtime Error - Executing Data Memory\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 2) { //Exception 2
			printf("PC %X: Runtime Error - Accessing Code Memory as Data\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 3) { //Exception 3
			printf("PC %X: Runtime Error - User Mode Accessing OS\n", state->PC);
			free(state);
			return ret;
		}
	}
	if(!TRACE_OFF) {
		pictureStore(state);
		word output[2]; //Write end of file instruction
		output[0] = state->PC;
		output[1] = 0xC907; //Default exit file instruction
		fwrite(output, sizeof(word), 2, outbin);
	}
	free(state);
	printf("Trace completed without error.\n");
	return 0;
}