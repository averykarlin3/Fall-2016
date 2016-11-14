/*
 * CIS 240 HW 9: LC4 Simulator
 * object_files.h - declares functions for object_files.c
 */

#include "lc4.h"

/*
 * Check that the given file exists.
 * Params: pointer to file, pointer to filename.
 */
void file_check (FILE *file, char *filename);

/*
 * Changes a 4-bit word's endian.
 * Params: int to convert.
 */
int flip_endian (int word);

/*
 * Read an object file and modify the machine state accordingly.
 * Return a zero if successful and a non-zero error code if you encounter a
 * problem.
 * Params: poitner to filename, pointer to current machine state.
 */
int read_object_file (char *filename, machine_state *state);
