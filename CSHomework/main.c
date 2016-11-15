#include "lc4.h"

word sext(word n, int len) {
	if(n > pow(2, len - 1)) {
		word mask = ~((word) pow(2, len) - 1);
		return mask | n;
	}
	else	
		return n;
}

signWord complement2Dec(word n) {
	if(!(n & 0x8000)) {
		printf("Here\n");
		return n;
	}
	else {
		return -((signWord) ~n + 1);
	}
}

int main() {
	word inst = 0x0013;
	printf("%i\n", complement2Dec(sext(UIMM5(inst), 5)));
}