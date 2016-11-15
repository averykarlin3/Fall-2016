#include "lc4.h"

int main() {
	word inst = 0x0013;
	printf("%u\n", UIMM5(inst));
}