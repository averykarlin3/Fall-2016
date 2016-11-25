//---------------------------------------------------------
//DO NOT MODIFY:  averyk
//DO NOT MODIFY:  2607:f470:6:5001:b47a:623b:e5f9:1de7
//
//Question: #2
//Type in source code below
//---------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
	char name[50];
	int row;
	int column;
} seat;

int main() {
	char input = 0;
	int size = 0;
	seat* plane = 0;
	int fullSeat = 0;
	while(1) {
		printf("Choice (a,f,n,q): ");
		scanf(" %c", &input);
		switch(input) {
			case 'n':
				free(plane);
				fullSeat = 0;
				printf("Number of Seats: ");
				scanf("%i", &size);
				plane = (seat*) malloc(sizeof(seat) * size);
				break;
			case 'a':
				if(fullSeat == size) {
					printf("Airplane full\n");
				}
				else {
					char name[50];
					printf("Enter name: ");
					scanf("%s", &name);
					strncpy(plane[fullSeat].name, name, 50);
					printf("Enter row: ");
					scanf("%i", &(plane[fullSeat].row));
					printf("Enter column: ");
					scanf("%i", &(plane[fullSeat].column));
					fullSeat++;
				}
				break;
			case 'f':
			printf("Here\n");
			int searchColumn;
			int searchRow;
			printf("Enter row: ");
			scanf("%i", &searchRow);
			printf("Enter column: ");
			scanf("%i", &searchColumn);
			int found = 0;
			for(int i = 0; i < size; i++) {
				if(plane[i].row == searchRow && plane[i].row == searchColumn) {
					printf("Name: %s\n", plane[i].name);
					found = 1;
				}
			}
			if(!found)
				printf("Not found\n");
			break;
			case 'q':
				return 0;
		}
	}
}

//Why is a space needed in scanf
//When pointer vs not pointer with struct