#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>

#define MAXSIZE 100

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

void readTop();

queueNode* front = 0;
queueNode* back = 0;
stackNode* curr = 0;
queueNode* functFront = 0;
queueNode* functBack = 0;
int functCall = 0;
queueNode* saveFront = 0;
queueNode* saveBack = 0;
int stackSize = 0;