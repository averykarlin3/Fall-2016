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
	outbin = fopen(argv[1], "a");
	if(!outbin) {
		printf("Write Error - File Unable to be Written\n");
		return -4;
	}
	machine_state* state = (machine_state*) malloc(sizeof(machine_state));
	reset(state);
	for(int i = 2; i < argc; i++) {
		int read = read_object_file(argv[i], state);
		if(read == -1) {
			printf("Read Error - File %s Note Found\n", argv[i]);
			free(state);
			return read;
		}
		if(read == -2) {
			printf("Read Error - Object File %s Block Corrupt\n", argv[i]);
			free(state);
			return read;
		}
	}
	while(state->PC != 0x80FF && !TRACE_OFF) {
		int ret = update_state(state);
		if(ret == 1) {
			printf("PC %X: Runtime Error - Executing Data Memory\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 2) {
			printf("PC %X: Runtime Error - Accessing Code Memory as Data\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 3) {
			printf("PC %X: Runtime Error - User Mode Accessing OS\n", state->PC);
			free(state);
			return ret;
		}
		if(state->PC == 30)
			break;
	}
	free(state);
	printf("Trace completed without error.\n");
	return 0;
}