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
	char* op;
	struct queueNode* prev;
	struct queueNode* next;
} queueNode;

double stackPop();

void stackPush(double d);

char* queuePop();

void queuePush(char* s);

queueNode* front = 0;
queueNode* back = 0;
stackNode* curr = 0;
queueNode* functFront = 0;
queueNode* functBack = 0;
