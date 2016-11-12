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

double stackPop(stackNode* node);

void stackPush(double d, stackNode* node);

void queuePop(char* op, queueNode* front, queueNode* back);

void readTop(stackNode* curr);

void parse(char* s, queueNode* front, queueNode* back);

int action(char* op, stackNode* curr, queueNode* front, queueNode* back);

void readTop(stackNode* curr);

queueNode* functFront = 0;
queueNode* functBack = 0;
int functCall = 0;
queueNode* saveFront = 0;
queueNode* saveBack = 0;
int stackSize = 0;