#include "lc4.h"

int main() {
	word inst = 0x0013;
	printf("%u", UIMM5(inst));
}