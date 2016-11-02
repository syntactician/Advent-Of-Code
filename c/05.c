#include <stdio.h>
#include <string.h>

static int has_bad_string(const char *);
static int has_double_letter(const char *);
static int is_vowel(const char);
static int has_three_vowels(const char *);

static int has_double_pair(const char *);
static int has_repeating_letter(const char *);

static int is_nice_a(const char *);
static int is_nice_b(const char *);

int
has_bad_string(const char *str)
{
	const char *bad_str[] = {"ab", "cd", "pq", "xy"};
	unsigned long int i;

	for (i = 0; i < sizeof(bad_str) / sizeof(bad_str[0]); ++i)
		if (strstr(str, bad_str[i]))
			return 1;
	return 0;
}

int
has_double_letter(const char *str)
{
	unsigned long int i;

	for (i = 0; i < strlen(str) - 1; ++i)
		if (str[i] == str[i + 1])
			return 1;
	return 0;
}

int
is_vowel(const char c)
{
	switch (c) {
	case 'a':
	case 'e':
	case 'i':
	case 'o':
	case 'u':
		return 1;
	default:
		return 0;
	}
}

int
has_three_vowels(const char *str)
{
	int vowels = 0;
	unsigned long int i;

	for (i = 0; i < strlen(str); ++i)
		if (is_vowel(str[i]))
			++vowels;

	return vowels >= 3;
}

int
has_double_pair(const char *str)
{
	char pair[3] = {'x', 'x', '\0'};
	unsigned long int i;

	for (i = 0; i <= strlen(str) - 3; ++i) {
		pair[0] = str[i];
		pair[1] = str[i + 1];
		if (strstr(&str[i + 2], pair))
			return 1;
	}
	return 0;
}

int
has_repeating_letter(const char *str)
{
	unsigned long int i;

	for (i = 0; i < strlen(str) - 2; ++i)
		if (str[i] == str[i + 2])
			return 1;
	return 0;
}

int
is_nice_a(const char *str)
{
	return !has_bad_string(str)
	    && has_double_letter(str)
	    && has_three_vowels(str);
}

int
is_nice_b(const char *str)
{
	return has_double_pair(str)
	    && has_repeating_letter(str);
}

int main(void)
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	unsigned int a, b;

	a = 0;
	b = 0;

	fp = fopen("../input/05.txt", "r");

	while (!(getline(&line, &len, fp) < 0)) {
		if (is_nice_a(line)) ++a;
		if (is_nice_b(line)) ++b;
	}

	fclose(fp);

	printf("%u\n", a);
	printf("%u\n", b);

	return 0;
}
