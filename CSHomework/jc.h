#include "token.h"

#define DATA_START 0x2000
#define OS_START 0x8000

typedef struct condLoop {
	int elseFound;
	int ifLayer;
	struct condLoop* prev;
} condLoop;

FILE* output;
int functNext = 0x1000;
int functLast = 0x0000;
int functLen = 0;
int compCount = 0;

condLoop* currentIf = 0;

//STRUCT INSIDE STRCT DECLARATION FORMAT