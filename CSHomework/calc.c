#include "calc.h"

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

void parse(char* s) { //Divide the input string into a series of tokens, pushing each onto the queue in order
	char* token;
	token = strtok(s, " \n\0\t");
	while(token != NULL) {
		queuePush(token);
		token = strtok(NULL, " \n\0\t");
	}
}

void readTop() { //Read the top item in the stack
	if(curr) {
		double top = stackPop();
		stackPush(top);
		printf("Current Top of Stack: %f\n", top);
	}
	else
		printf("None in Stack\n");
}

int check(char* s) {
	if(!strcmp(s, "+")) //Check if string is command
		return 1;
	if(!strcmp(s, "-"))
		return 1;
	if(!strcmp(s, "*"))
		return 1;
	if(!strcmp(s, "/"))
		return 1;
	if(!strcmp(s, "sin"))
		return 1;
	if(!strcmp(s, "cos"))
		return 1;
	if(!strcmp(s, "rand"))
		return 1;
	if(!strcmp(s, "sqrt"))
		return 1;
	if(!strcmp(s, "pow"))
		return 1;
	if(!strcmp(s, "neg"))
		return 1;
	if(!strcmp(s, "swap"))
		return 1;
	if(!strcmp(s, "pop"))
		return 1;
	if(!strcmp(s, "print"))
		return 1;
	if(!strcmp(s, "quit"))
		return 1;
	int isNumber = 1; //Check if string is number
	int decimalFound = 0;
	for(int i = 0; i < strnlen(s, MAXSIZE); i++) {
		if(i == 0 && s[i] == 45 && strnlen(s, MAXSIZE) > 1) { //Check for digits
			continue;
		}
		if(s[i] == 46 && !decimalFound) { //Check for decimal point
			decimalFound = 1;
			continue;
		}
		if(s[i] < 48 || s[i] > 57) { //Check for illegitimate character
			isNumber = 0;
			break;
		}
	}
	if(isNumber)
		return 1;
	return 0; //Return 0 if not command or number
}

int action(char* op) {
	int notEnough = 1; //Enough parameters for command?
	int isNumber = 1;
	int notDone = 1; //Quit command not given?
	int decimalFound = 0;
	int functFound = 0; //Legitimate command given?
	for(int i = 0; i < strnlen(op, MAXSIZE); i++) { 
		if(i == 0 && op[i] == 45 && strnlen(op, MAXSIZE) > 1) { //Check for digits
			continue;
		}
		if(op[i] == 46 && !decimalFound) { //Check for decimal point
			decimalFound = 1;
			continue;
		}
		if(op[i] < 48 || op[i] > 57) { //Check for illegitimate character
			isNumber = 0;
			break;
		}
	}
	if(isNumber) {
		functFound = 1;
		stackPush(atof(op));
		notEnough = 0;
	}
	if(!strcmp(op, "+")) { //Arithmatic commands
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			double newOp = op1 + op2;
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "-")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			double newOp = op2 - op1;
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "*")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			double newOp = op1 * op2;
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "/")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			double newOp = op1 / op2;
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "sin")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop();
			double newOp = sin(op1);
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "cos")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop();
			double newOp = cos(op1);
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "neg")) {
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			double op1 = stackPop();
			double newOp = -1*op1;
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "rand")) {
		functFound = 1;
		double newOp = (rand()/((double) RAND_MAX));
		stackPush(newOp);
	}
	if(!strcmp(op, "swap")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			stackPush(op1);
			stackPush(op2);
		}
	}
	if(!strcmp(op, "pop")) { //Remove top value from stack
		functFound = 1;
		if(stackSize >= 1) {
			notEnough = 0;
			stackPop();
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
			double op1 = stackPop();
			double newOp = sqrt(op1);
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "pow")) {
		functFound = 1;
		if(stackSize >= 2) {
			notEnough = 0;
			double op1 = stackPop();
			double op2 = stackPop();
			double newOp = pow(op2, op1);
			stackPush(newOp);
		}
	}
	if(!strcmp(op, "def")) { //Define function
		notEnough = 0;
		functFound = 1;
		queueNode* test = back;
		int allowed = 1;
		if(test) {	//Check if empty function
			allowed = check(test->op); //Test first item in function
			test = test->above;
		}
		while(test && allowed) { //Test next items in function
			allowed = check(test->op);
			test = test->above;
		}
		if(allowed) { //Store function if allowed
			functFront = front;
			functBack = back;
		}
		else {
			printf("INVALID DEF\n");
		}
		front = 0;
		back = 0;
	}
	if(!strcmp(op, "print")) { //Print stack without popping
		functFound = 1;
		notEnough = 0;
		queueNode* first = 0; 
		queueNode* next = 0;
		queueNode* top;
		double value;
		if(curr) { //If there is a first node
			first = (queueNode*) malloc(sizeof(queueNode));
			value = stackPop();
			sprintf(first->op, "%f", value);
			first->below = 0; //Load value into a queue
			first->above = 0;
			top = first;
			printf("%s\n", first->op);
			next = first;
		}
		while(curr) { //Read next node by popping, reading, and adding to queue
			next = (queueNode*) malloc(sizeof(queueNode));
			value = stackPop();
			sprintf(next->op, "%f", value);
			next->below = top;
			next->above = 0;
			top->above = next;
			top = next;
			printf("%s\n", next->op);
		}
		while(next) { //
			stackPush(atof(next->op)); //Restore values from queue
			next = next->below;
		} 
	}
	if(!strcmp(op, "call_func")) { //Move function definition into input queue
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
	if(!strcmp(op, "print_func")) { //Print items in function definition
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
	int isNumber; //Signifies if done with calculator
	int notDone = 1;
	while(1) {
		if(functCall) { //Check if just finished function call and restore
			functCall = 0;
			front = saveFront;
			back = saveBack;
			saveFront = 0;
			saveBack = 0;
		}
		if(!front) { //Get new command
			printf("\n");
			char* input = (char*) malloc(MAXSIZE);
			fgets(input, MAXSIZE, stdin);
			parse(input);
			free(input);
		}
		while(notDone && front) { //Iterate through command stream
			char op[MAXSIZE];
			queuePop(op);
			for(int i = 0; i < strnlen(op, MAXSIZE); i++)
				op[i] = tolower(op[i]);
			notDone = action(op);
			readTop();
		}
		if(!notDone) { //Clear structures
			while(curr) {
				stackPop();
			}
			while(front) {
				char op[MAXSIZE];
				queuePop(op);
			}
			printf("\n");
			break;
		}
	}
	return 0;
}