#include "lc4.h"

int sext(word n, int len) {
	if(n > pow(2, len - 1)) {
		int mask = ~(pow(2, len) - 1);
		return mask | n;
	}
	else	
		return n;
}

int main() {
	word inst = 0x0013;
	printf("%u\n", sext(UIMM5(inst), 5));
}