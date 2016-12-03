#include "token.h"

#define DATA_START 0x2000
#define OS_START 0x8000

typedef struct {
	int elseFound;
	int ifLayer;
	condLoop* prev;
} condLoop

FILE* output;
int functNext = 0x1000;
int functLast = 0x0000;

condLoop* currentIf = 0;