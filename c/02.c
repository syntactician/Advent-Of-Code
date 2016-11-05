#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
	FILE *fp;
	char *line = NULL;
	char *token = NULL;
	size_t len;
	
	int i, a, b;
	long int max, sides[3];

	a = 0;
	b = 0;

	fp = fopen("../input/02.txt", "r");

	while (!(getline(&line, &len, fp) < 0)) {
		token = strtok(line, "x");
		for (i = 0; i < 3; ++i, token = strtok(NULL, "x"))
			sides[i] = strtol(token, NULL, 10);
		for (i = 0; i < 3; ++i)
			a += 2 * sides[i] * sides[(i+1) % 3];
		for (i = 0, max = 0; i < 3; ++i)
			if (sides[max] < sides[i])
				max = i;

		a += sides[(max + 1) % 3] * sides[(max + 2) % 3];
		b += 2 * (sides[(max + 1) % 3] + sides[(max + 2) % 3])
			+ sides[0] * sides[1] * sides[2];
	}

	fclose(fp);
	free(line);

	printf("%d\n", a);
	printf("%d\n", b);

	return 0;
}
