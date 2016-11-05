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

		if (c == '(')
			++floor;
		else if (c == ')')
			--floor;
		else
			break;

		if (!basement && floor < 0) 
			basement = count;
	}

	fclose(fp);

	printf("%d\n", floor);
	printf("%d\n", basement);

	return 0;
}
