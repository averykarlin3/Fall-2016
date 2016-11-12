#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>

typedef struct stackNode {
	double op;
	struct stackNode* next;
} stackNode;

typedef struct queueNode {
	char op[MAXSIZE];
	struct queueNode* below;
	struct queueNode* above;
} queueNode;

double stackPop();

void stackPush(double d);

void queuePop(char* op);

void queuePush(char* s);

queueNode* front = 0;
queueNode* back = 0;
stackNode* curr = 0;
queueNode* functFront = 0; //Function queue save location
queueNode* functBack = 0;
int functCall = 0; //Check if inside function call
queueNode* saveFront = 0; //Temporary queue save location
queueNode* saveBack = 0;
int stackSize = 0; //Current size of stack