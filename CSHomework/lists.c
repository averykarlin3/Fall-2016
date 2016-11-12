#include "lists.h"

double stackPop() { //Pop the top value from the calculator stack, and return as double
	double popped = curr->op;
	stackNode* newCurr = curr->next;
	free(curr);
	curr = newCurr;
	stackSize--;
	return popped;
}

void stackPush(double d) { //Push a double onto the top of the stack
	stackNode* new = (stackNode*) malloc(sizeof(stackNode));
	new->op = d;
	new->next = curr;
	curr = new;
	stackSize++;
}

void queuePop(char* op) { //Pop the last item off of the queue into the string variable inputted
	strncpy(op, back->op, MAXSIZE);
	queueNode* newBack = back->above;
	if(!functCall)
		free(back);
	back = newBack;
	if(back)
		back->below = 0;
	else
		front = 0;
}

void queuePush(char* s) { //Push the string onto the start of the queue
	queueNode* new = (queueNode*) malloc(sizeof(queueNode));
	strncpy(new->op, s, MAXSIZE);
	new->below = front;
	new->above = 0;
	if(front)
		front->above = new;
	front = new;
	if(!back) {
		back = new;
	}
}