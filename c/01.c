#include <stdio.h>
#include <stdlib.h>

int
main(void)
{
	int basement, c, count, floor;
	FILE *fp = fopen("../input/01.txt", "r");

	basement = 0;
	count = 0;
	floor = 0;

	while ((c = fgetc(fp)) != EOF) {
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
