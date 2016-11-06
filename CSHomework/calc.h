#include <stdio.h>
#include <string.h>
#include <math.h>
#include <ctype.h>
#include <stdlib.h>

#define MAXSIZE 100

node pop(node* curr);

void push(char* str, node* curr);

typedef struct {
	double op;
	node* next;
} node;