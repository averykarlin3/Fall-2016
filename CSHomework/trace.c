/*
 * CIS 240 HW 9: LC4 Simulator
 * trace.c
 */

#include <stdio.h>
#include <stdlib.h>

#include "objectfiles.h"

int main(int argc, char const *argv[])
{
  //TODO: Initialize machine state and control signals

	reset(state);

  // TODO: Read in object files

	while(state->PC != 0x80FF) {
		// TODO: Simulate LC4
	}

	printf("Trace completed without error.\n");

	return 0;
}
