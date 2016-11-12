#include "calc.h"

double stackPop(stackNode* node) {
	double popped = node->op;
	stackNode* newCurr = node->next;
	free(node);
	node = newCurr;
	stackSize--;
	return popped;
}

void stackPush(double d, stackNode* node) {
	stackNode* new = (stackNode*) malloc(sizeof(stackNode));
	new->op = d;
	new->next = node;
	node = new;
	stackSize++;
}

void queuePop(char* op, queueNode* front, queueNode* back) {
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

void queuePush(char* s, queueNode* front, queueNode* back) {
	queueNode* new = (queueNode*) malloc(sizeof(queueNode));
	//printf("%p\n", back);
	strncpy(new->op, s, MAXSIZE);
	new->below = front;
	new->above = 0;
	if(front)
		front->above = new;
	front = new;
	if(!back) {
		back = new;
	}
	//printf("%p\n", back);
}

void parse(char* s, queueNode* front, queueNode* back) {
	char* token;
	token = strtok(s, " \n\0\t");
	while(token != NULL) {
		queuePush(token, front, back);
		printf("%p\n", back);
		token = strtok(NULL, " \n\0\t");
	}
}

void readTop(stackNode* curr) {
	if(curr) {
		double top = stackPop(curr);
		stackPush(top, curr);
		printf("Current Top of Stack: %f\n", top);
	}
	else
		printf("None in Stack\n");
}

int action(char* op, stackNode* curr, queueNode* front, queueNode* back) {
	printf("%s\n", op);
	int notEnough = 1;
	int isNumber = 1;
	int notDone = 1;
	int decimalFound = 0;
	int functFound = 0;
	for(int i = 0; i < strnlen(op, MAXSIZE); i++) {
		if(i == 0 && op[i] == 45 && strnlen(op, MAXSIZE) > 1) {
			continue;
		}
		if(op[i] == 46 && !decimalFound) {
			decimalFound = 1;
			continue;
		}
		if(op[i] < 48 || op[i] > 57) {
			isNumber = 0;
			break;
		}
	}
	if(isNumber) {
		functFound = 1;
		stackPush(atof(op), curr);
		notEnough = 0;
	}
	if(!strcmp(op, "+")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			double newOp = op1 + op2;
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "-")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			double newOp = op2 - op1;
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "*")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			double newOp = op1 * op2;
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "/")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			double newOp = op1 / op2;
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "sin")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double newOp = sin(op1);
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "cos")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double newOp = cos(op1);
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "neg")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double newOp = -1*op1;
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "rand")) {
		functFound = 1;
		double newOp = (rand()/((double) RAND_MAX));
		stackPush(newOp, curr);
	}
	if(!strcmp(op, "swap")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			stackPush(op1, curr);
			stackPush(op2, curr);
		}
	}
	if(!strcmp(op, "pop")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			stackPop(curr);
		}
	}
	if(!strcmp(op, "quit")) {
		functFound = 1;
		notEnough = 0;
		notDone = 0;
	}
	if(!strcmp(op, "sqrt")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double newOp = sqrt(op1);
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "pow")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop(curr);
			double op2 = stackPop(curr);
			double newOp = pow(op2, op1);
			stackPush(newOp, curr);
		}
	}
	if(!strcmp(op, "def")) {
		notEnough = 0;
		functFound = 1;
		functFront = front;
		functBack = back;
		front = 0;
		back = 0;
	}
	if(!strcmp(op, "print")) {
		functFound = 1;
		//ADD
	}
	if(!strcmp(op, "call_func")) {
		notEnough = 0;
		functFound = 1;
		if(functFront) {
			functCall = 1;
			saveFront = front;
			saveBack = back;
			front = functFront;
			back = functBack;
		}
		else {
			printf("NO FUNCTION DEFINED\n");
		}
	}
	if(!strcmp(op, "print_func")) {
		notEnough = 0;
		functFound = 1;
		if(functFront) {
			queueNode* read = functBack;
			while(read) {
				printf("%s\n", read->op);
				read = read->above;
			}
		}
		else {
			printf("NO FUNCTION DEFINED\n");
		}
	}
	if(notEnough && functFound)
		printf("STACK ERROR: %s\n", op);
	if(!functFound)
		printf("INVALID COMMAND: %s\n", op);
	return notDone;
}


int main() {
	int isNumber;
	int notDone = 1;
	stackNode* curr = 0;
	queueNode* front = 0;
	queueNode* back = 0;
	while(1) {
		if(functCall) {
			functCall = 0;
			front = saveFront;
			back = saveBack;
			saveFront = 0;
			saveBack = 0;
		}
		if(!front) {
			printf("\n");
			char* input = (char*) malloc(MAXSIZE);
			fgets(input, MAXSIZE, stdin);
			parse(input, front, back);
			free(input);
		}
		while(notDone && front) { //Check if more operations
			printf("Here\n");
			char op[MAXSIZE];
			queuePop(op, front, back);
			for(int i = 0; i < strnlen(op, MAXSIZE); i++)
				op[i] = tolower(op[i]);
			notDone = action(op, curr, front, back);
			readTop(curr);
		}
		if(!notDone) {
			while(curr) {
				stackPop(curr);
			}
			while(front) {
				char op[MAXSIZE];
				queuePop(op, front, back);
			}
			printf("\n");
			break;
		}
	}
	return 0;
}