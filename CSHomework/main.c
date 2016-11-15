#include "lc4.h"

signed int sext(word n, int len) {
	if(n > pow(2, len - 1)) {
		int mask = ~((int) pow(2, len) - 1);
		printf("%08x\n", mask);
		return mask | n;
	}
	else	
		return n;
}

signWord complement2Dec(word n) {
	if(!(n & 0x8000))
		return n;
	else {
		return -((~n) + 1);
	}
}

int main() {
	word inst = 0x0013;
	printf("%08x\n", complement2Dec(sext(UIMM5(inst), 5)));
}