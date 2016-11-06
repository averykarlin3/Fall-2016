#include "calc.h"

double pop(node* curr) {
	double popped = curr->op;
	newCurr = curr->next;
	free(curr);
	curr = newCurr;
	return popped;
}

void push(double d, node* curr) {
	node* new = (node*) malloc(sizeof(node));
	new->op = d;
	new->next = curr;
	curr = &new;
}

int main() {
	node* curr = 0;
	int isNumber;
	int notDone = 1;
	while(1) {
		char input[MAXSIZE];
		scanf("%s", &input);
		while(remain && notDone) { //Check if more operations
			char op[OPSIZE]; //Take first operation from input
			char remain[MAXSIZE];
			remain = strtok(input, ' ');
			strcpy(op, input);
			isNumber = 1; //Check if operator is a number/push it
			for(int i = 0; i < strlen(op); i++) {
				if(i = 0 && op[i] == 45) {
					continue;
				}
				if(op[i] < 48 || op[i] > 57) {
					isNumber = 0;
					break;
				}
			}
			if(isNumber) {
				push(atof(op), curr);
			}
			if(!strcmp(op, "+")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				double newOp = op1 + op2;
				push(newOp, curr);
			}
			if(!strcmp(op, "-")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				double newOp = op2 - op1;
				push(newOp, curr);
			}
			if(!strcmp(op, "*")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				double newOp = op2 * op1;
				push(newOp, curr);
			}
			if(!strcmp(op, "/")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				double newOp = op1 / op2;
				push(newOp, curr);
			}
			if(!strcmp(op, "sin")) {
				double op1 = pop(curr);
				double newOp = sin(op1);
				push(newOp, curr);
			}
			if(!strcmp(op, "cos")) {
				double op1 = pop(curr);
				double newOp = cos(op1);
				push(newOp, curr);
			}
			if(!strcmp(op, "neg")) {
				double op1 = pop(curr);
				double newOp = -1*op1;
				push(newOp, curr);
			}
			if(!strcmp(op, "rand")) {
				double newOp = (rand()/((double) RAND_MAX));
				push(newOp, curr);
			}
			if(!strcmp(op, "swap")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				push(op1, curr);
				push(op2, curr);
			}
			if(!strcmp(op, "pop")) {
				pop(curr);
			}
			if(!strcmp(op, "quit")) {
				notDone = 0;
			}
			if(!strcmp(op, "sqrt")) {
				double op1 = pop(curr);
				double newOp = sqrt(op1);
				push(newOp, curr);
			}
			if(!strcmp(op, "pow")) {
				double op1 = pop(curr);
				double op2 = pop(curr);
				double newOp = pow(op2, op1);
				push(newOp, curr);
			}
		}
		if(!notDone) {
			while(curr) {
				pop(curr);
			}
			break;
		}
	}
	return 0;
}
