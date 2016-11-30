//---------------------------------------------------------
//DO NOT MODIFY:  averyk
//DO NOT MODIFY:  2607:f470:6:5001:b47a:623b:e5f9:1de7
//
//Question: #1
//Type in source code below
//---------------------------------------------------------

#include <math.h>
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char* argv[]) {
	int n = 0;
	int num = 0;
	printf("Enter Number: ");
	scanf("%i", &num);
	int total = 0;
	while(pow(2, n) < num) {
		n++;
	}
	while(n >= 0) {
		if(pow(2, n) <= num) {
			num -= pow(2, n);
			total++;
		}
		n--;
	}
	printf("Answer: %i\n", total);
	return 0;
}

//Scanf doesn't end with \n
//<> use printf and scanf as normal
//Printf doesn't use \n before scanf