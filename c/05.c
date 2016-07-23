#include <stdbool.h>
#include <stdio.h>
#include <string.h>

static bool has_bad_string(const char *);
static bool has_double_letter(const char *);
static bool is_vowel(const char);
static bool has_three_vowels(const char *);

static bool has_double_pair(const char *);
static bool has_repeating_letter(const char *);

static bool is_nice_a(const char *);
static bool is_nice_b(const char *);

static bool has_bad_string(const char *str)
{
	const char *bad_str[] = {"ab", "cd", "pq", "xy"};

	for (int i = 0; i < sizeof(bad_str)/sizeof(bad_str[0]); ++i)
		if (strstr(str, bad_str[i]))
			return true;
	return false;
}

static bool has_double_letter(const char *str)
{
	for (int i = 0; i < strlen(str) - 1; ++i)
		if (str[i] == str[i + 1])
			return true;
	return false;
}

static bool is_vowel(const char c)
{
	switch(c) {
		case 'a':
		case 'e':
		case 'i':
		case 'o':
		case 'u':
			return true;
			break;
		default:
			return false;
			break;
	}
}

static bool has_three_vowels(const char *str)
{
	int vowels = 0;

	for (int i = 0; i < strlen(str); ++i)
		if (is_vowel(str[i]))
			++vowels;

	if (vowels >= 3)
		return true;
	else
		return false;
}

static bool has_double_pair(const char *str)
{
	char pair[3] = {'x', 'x', '\0'};
	for (int i = 0; i <= strlen(str) - 3; ++i)
	{
		pair[0] = str[i];
		pair[1] = str[i + 1];
		if (strstr(&str[i + 2], pair))
			return true;
	}
	return false;
}

static bool has_repeating_letter(const char *str)
{
	for (int i = 0; i < strlen(str) - 2; ++i)
		if (str[i] == str[i + 2])
			return true;
	return false;
}

static bool is_nice_a(const char *str)
{
	if (has_bad_string(str))
		return false;
	else if (!has_double_letter(str))
		return false;
	else if (!has_three_vowels(str))
		return false;
	else
		return true;
}

static bool is_nice_b(const char *str)
{
	if (!has_double_pair(str))
		return false;
	else if (!has_repeating_letter(str))
		return false;
	else
		return true;
}

int main(void)
{
	FILE *fp;
	char *line = NULL;
	size_t len = 0;
	ssize_t read = 0;

	unsigned int a = 0,
				 b = 0;

	fp = fopen("../input/05.txt", "r");

	while ((read = getline(&line, &len, fp)) != -1) {
		if (is_nice_a(line)) ++a;
		if (is_nice_b(line)) ++b;
	}

	fclose(fp);

	printf("%u\n", a);
	printf("%u\n", b);

	return 0;
}
