#include "token.h"

#define DATA_START 0x2000
#define OS_START 0x8000

typedef struct condLoop {
	int elseFound;
	int ifLayer;
	struct condLoop* prev;
} condLoop;

FILE* output;
int compCount = 0;

condLoop* currentIf = 0;

//STRUCT INSIDE STRCT DECLARATION FORMAT