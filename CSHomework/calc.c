#include "calc.h"

double stackPop() {
	double popped = curr->op;
	stackNode* newCurr = curr->next;
	free(curr);
	curr = newCurr;
	return popped;
}

void stackPush(double d) {
	stackNode* new = (stackNode*) malloc(sizeof(stackNode));
	new->op = d;
	new->next = curr;
	curr = new;
}

char* queuePop() {
	char* popped = back->op;
	queueNode* newBack = back->prev;
	free(back);
	back = newBack;
	back->next = 0;
	return popped;
}

void queuePush(char* s) {
	queueNode* new = (queueNode*) malloc(sizeof(queueNode));
	new->op = s;
	new->next = front;
	new->prev = 0;
	front = new;
}

void parse(char* s) {
	char* token;
	token = strtok(s, " \n");
	while(token != NULL) {
		token = strtok(NULL, " \n");
		queuePush(token);
	}
}

int main() {
	int isNumber;
	int notDone = 1;
	while(1) {
		char* input = malloc(MAXSIZE);
		fgets(input, MAXSIZE, stdin);
		printf("1");
		parse(input);
		free(input);
		while(notDone) { //Check if more operations
			isNumber = 1; //Check if operator is a number/stackPush it
			char* op = queuePop();
			if(op[0] == '\0')
				notDone = 0;
			for(int i = 0; i < strnlen(op, MAXSIZE); i++) {
				if(i == 0 && op[i] == 45) {
					continue;
				}
				if(op[i] < 48 || op[i] > 57) {
					isNumber = 0;
					break;
				}
			}
			if(isNumber) {
				stackPush(atof(op));
			}
			if(!strcmp(op, "+")) {
				double op1 = stackPop();
				double op2 = stackPop();
				double newOp = op1 + op2;
				stackPush(newOp);
			}
			if(!strcmp(op, "-")) {
				double op1 = stackPop();
				double op2 = stackPop();
				double newOp = op2 - op1;
				stackPush(newOp);
			}
			if(!strcmp(op, "*")) {
				double op1 = stackPop();
				double op2 = stackPop();
				double newOp = op2 * op1;
				stackPush(newOp);
			}
			if(!strcmp(op, "/")) {
				double op1 = stackPop();
				double op2 = stackPop();
				double newOp = op1 / op2;
				stackPush(newOp);
			}
			if(!strcmp(op, "sin")) {
				double op1 = stackPop();
				double newOp = sin(op1);
				stackPush(newOp);
			}
			if(!strcmp(op, "cos")) {
				double op1 = stackPop();
				double newOp = cos(op1);
				stackPush(newOp);
			}
			if(!strcmp(op, "neg")) {
				double op1 = stackPop();
				double newOp = -1*op1;
				stackPush(newOp);
			}
			if(!strcmp(op, "rand")) {
				double newOp = (rand()/((double) RAND_MAX));
				stackPush(newOp);
			}
			if(!strcmp(op, "swap")) {
				double op1 = stackPop();
				double op2 = stackPop();
				stackPush(op1);
				stackPush(op2);
			}
			if(!strcmp(op, "stackPop")) {
				stackPop();
			}
			if(!strcmp(op, "quit")) {
				notDone = 0;
			}
			if(!strcmp(op, "sqrt")) {
				double op1 = stackPop();
				double newOp = sqrt(op1);
				stackPush(newOp);
			}
			if(!strcmp(op, "pow")) {
				double op1 = stackPop();
				double op2 = stackPop();
				double newOp = pow(op2, op1);
				stackPush(newOp);
			}
			if(!strcmp(op, "def")) {
				functFront = front;
				functBack = back;
				front = 0;
				back = 0;
			}
			if(!strcmp(op, "call_function")) {
				
			}
			if(!strcmp(op, "print_function")) {

			}
			double top = stackPop();
			stackPush(top);
			printf("Top of Stack: %f", top);
		}
		if(!notDone) {
			while(curr) {
				stackPop();
			}
			break;
		}
	}
	return 0;
}
