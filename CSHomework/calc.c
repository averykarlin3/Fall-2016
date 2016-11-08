#include "calc.h"

double stackPop() {
	printf("Poppin\n");
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

void queuePop(char* op) {
	printf("Pop:%s\n", back->op);
	printf("Above:%p\n", back->above);
	strncpy(op, back->op, MAXSIZE);
	queueNode* newBack = back->above;
	printf("%s\n", op);
	if(!functCall)
		free(back);
	printf("%s\n", op);
	printf("%p\n", back);
	back = newBack;
	printf("%p\n", back);
	printf("BeforeEnd:%s\n", op);
	back->below = 0;
	printf("End:%s\n", op);
}

void queuePush(char* s) {
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

void parse(char* s) {
	char* token;
	token = strtok(s, " \n\0");
	while(token != NULL) {
		queuePush(token);
		printf("%s\n", token);
		token = strtok(NULL, " \n\0");
	}
}

void readTop() {
	double top = stackPop();
	stackPush(top);
	printf("Current Top of Stack: %f\n", top);
}

int action(char* op) {
	int isNumber = 1;
	int notDone = 1;
	printf("%s\n", op);
	for(int i = 0; i < strnlen(op, MAXSIZE); i++) {
		if(i == 0 && op[i] == 45) {
			continue;
		}
		if(op[i] < 48 || op[i] > 57) {
			isNumber = 0;
			break;
		}
	}
	printf("%i\n", isNumber);
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
		functCall = 1;
		saveFront = front;
		saveBack = back;
		front = functFront;
		back = functBack;
	}
	if(!strcmp(op, "print_function")) {
		queueNode* read = functBack;
		while(read) {
			printf("%s\n", read->op);
			read = read->above;
		}
	}
	return notDone;
}

//int checkCommand()

int main() {
	int isNumber;
	int notDone = 1;
	while(1) {
		char* input = (char*) malloc(MAXSIZE);
		if(functCall) {
			front = 0;
			back = 0;
			functCall = 0;
			front = saveFront;
			back = saveBack;	
		}
		fgets(input, MAXSIZE, stdin);
		parse(input);
		free(input);
		while(notDone && front) { //Check if more operations
			char op[MAXSIZE];
			queuePop(op);
			printf("%s\n", op);
			notDone = action(op);
			readTop();
		}
		if(!notDone) {
			while(curr) {
				stackPop();
			}
			while(front) {
				char op[MAXSIZE];
				queuePop(op);
			}
			break;
		}
	}
	return 0;
}