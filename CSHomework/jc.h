#include "token.h"

#define DATA_START 0x2000
#define OS_START 0x8000

typedef struct condLoop {
	int elseFound;
	int ifID;
	struct condLoop* prev;
} condLoop;

FILE* output;
int compCount = 0;
int ifCount = 0;

condLoop* currentIf = 0;