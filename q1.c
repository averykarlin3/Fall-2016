#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main() {
	unsigned int n = 0;
	printf("Enter number: ");
	scanf(" %u", &n);
	unsigned int newN = 0;
	for(int i = 0; i < 32; i++) {
		newN = newN | ((n & 1) << 31 - i);
		n = n >> 1;
	}
	printf("Answer: %u\n", newN);
	return 0;
}