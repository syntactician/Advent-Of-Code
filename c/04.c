#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <openssl/md5.h>

int
main(void)
{
	MD5_CTX ctx;
	char hash[7], str[10];
	char prefix[] = "ckczppom";
	int i = 1;
	unsigned char digest[MD5_DIGEST_LENGTH];
	unsigned int test_length = 5;

	while (i > 0) {
		MD5_Init(&ctx);
		MD5_Update(&ctx, prefix, strlen(prefix));

		sprintf(str, "%u", i);
		MD5_Update(&ctx, str, strlen(str));
		MD5_Final(digest, &ctx);

		for (int j = 0; j < 16; ++j)
			sprintf(&hash[j*2], "%02x", digest[j]);

		if (!strncmp("000000", hash, test_length)) {
			printf("%u\n", i);
			++test_length;
			if (test_length > 6)
				break;
		}
		++i;
	}
	return 0;
}
