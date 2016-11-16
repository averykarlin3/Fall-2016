/*
 * CIS 240 HW 9: LC4 Simulator
 * trace.c
 */

#include <stdio.h>
#include <stdlib.h>
#include "objectfiles.h"

int main(int argc, char const *argv[]) {
	machine_state* state = (machine_state*) malloc(sizeof(machine_state));
	reset(state);
	for(int i = 1; i < argc; i++) {
		int read = read_object_file(argv[i], state);
		if(read == -1) {
			printf("Read Error: File %s Note Found", argv[i]);
		}
		if(read == -2) {
			printf("Read Error: Object File %s Block Corrupt", argv[i]);
		}
	}
	while(state->PC != 0x80FF) {
		update_machine_state(state);
	}
	printf("Trace completed without error.\n");
	return 0;
}

//CHECK OTHER ERROR POSSIBILITIES