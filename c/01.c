#include <stdio.h>
#include <stdlib.h>

int main(void) {
	FILE *fp;
	int basement, c, count, floor;

	fp = fopen("../input/01.txt", "r");
	basement = count = floor = 0;

	while ((c = fgetc(fp)) != EOF)
	{
		++count;

		(c == '(') ? ++floor : (c == ')') ? --floor : floor ;

		if (!basement && floor == -1) 
			basement = count;
	}

	fclose(fp);

	printf("%d\n", floor);
	printf("%d\n", basement);

	return 0;
}
