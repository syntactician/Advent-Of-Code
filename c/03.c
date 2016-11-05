#include <stdio.h>
#include <stdlib.h>

typedef struct PointList {
	long x, y;
	struct PointList *next;
} PointList;

int PointList_check(PointList *head, PointList pos);
void PointList_add(PointList **head, PointList pos);
long PointList_length(PointList *head);
void PointList_free(PointList **head);
PointList *PointList_switcher(PointList *prev, PointList *a, PointList *b);

int
PointList_check(PointList *head, PointList pos)
{
	while (head) {
		if (head->x == pos.x && head->y == pos.y) {
			return 1;
		}
		head = head->next;
	}
	return 0;
}

void
PointList_add(PointList **head, PointList pos)
{
	PointList *new = (PointList *) malloc(sizeof(PointList));
	new->x = pos.x;
	new->y = pos.y;
	new->next = *head;
	*head = new;
}

long 
PointList_length(PointList *head)
{
	long length = 0;
	while (head) {
		++length;
		head = head->next;
	}
	return length;
}

void
PointList_free(PointList **head)
{
	PointList *next;
	while (*head) {
		next = *head;
		*head = next->next;
		free(next);
	}
}

PointList *
PointList_switcher(PointList *prev, PointList *a, PointList *b)
{
	return prev == a ? b : a;
}

int
main(void)
{
	FILE *fp;
	int c;

	PointList *a_head = NULL;
	PointList *b_head = NULL;

	PointList pos = {0, 0, NULL};

	PointList anthro_pos = {0, 0, NULL};
	PointList robo_pos = {0, 0, NULL};
	PointList *current = NULL;

	fp = fopen("../input/03.txt", "r");

	PointList_add(&a_head, pos);
	PointList_add(&b_head, anthro_pos);

	current = &anthro_pos;

	while ((c = fgetc(fp)) != EOF) {
		switch (c) {
		case '^':
			pos.y++;
			current->y++;
			break;
		case '>':
			pos.x++;
			current->x++;
			break;
		case 'v':
			pos.y--;
			current->y--;
			break;
		case '<':
			pos.x--;
			current->x--;
			break;
		}
		if (!PointList_check(a_head, pos))
			PointList_add(&a_head, pos);
		if (!PointList_check(b_head, *current))
			PointList_add(&b_head, *current);
		current = PointList_switcher(current, &anthro_pos, &robo_pos);
	}

	fclose(fp);

	printf("%ld\n", PointList_length(a_head));
	printf("%ld\n", PointList_length(b_head));

	PointList_free(&a_head);
	PointList_free(&b_head);
	return 0;
}
