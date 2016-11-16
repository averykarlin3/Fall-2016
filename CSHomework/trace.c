/*
 * CIS 240 HW 9: LC4 Simulator
 * trace.c
 */

#include "object_files.h"

int main(int argc, char *argv[]) {
	machine_state* state = (machine_state*) malloc(sizeof(machine_state));
	reset(state);
	for(int i = 1; i < argc; i++) {
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
	while(state->PC != 0x80FF) {
		int ret = update_state(state);
		if(ret == 1) {
			printf("%x: Runtime Error - Executing Data Memory\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 2) {
			printf("%x: Runtime Error - Accessing Code Memory as Data\n", state->PC);
			free(state);
			return ret;
		}
		if(ret == 3) {
			printf("%x: Runtime Error - User Mode Accessing OS\n", state->PC);
			free(state);
			return ret;
		}
	}
	free(state);
	printf("Trace completed without error.\n");
	return 0;
}

//CHECK OTHER ERROR POSSIBILITIES