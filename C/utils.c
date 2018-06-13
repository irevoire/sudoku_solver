#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char *parse(FILE *input)
{
	char *grid = malloc(100);
	char *line, *current;
	long unsigned len;
	int read;

	int y = 0;
	int x;

	memset(grid, -2, 100);

	while ((read = getline(&line, &len, input)) != -1)
	{
		current = line;

		printf("len = %d\n", len);
		for (x = 0; x < 9 && current < (line + len); x++, current++)
		{
			if (*current == ',' || *current == '\n')
			{
				x--;
				continue;
			}
			printf("%c", *current);
			if (*current == '_')
				grid[x * 10 + y] = -1;
			else
				grid[x * 10 + y] = *current - '0';
		}
		printf("\n");
		y += 1;
	}

	return grid;
}

#define DRAW_BLANK_LINE \
	do \
	{ \
	for (int i = 0; i < 9 * 4 + 2; i++) \
		printf("_"); \
	} while(0);

void dump_table(char *grid)
{
	DRAW_BLANK_LINE;

	printf("\n");

	for(int y = 0; y < 9;)
	{
		printf("|");

		for(int x = 0; x < 9;)
		{
			printf(" ");
			if(grid[10 * x + y] == -1)
				printf("\e[31;1mU\e[m");
			else
				printf("\e[32;1m%d\e[m", grid[10 * x + y]);
			printf(" |");

			x++;
	
			if (x % 3 == 0)
				printf(" ");
		}


		printf("\n");

		y++;

		if (y % 3 == 0)
			printf("\e[2K\n");
	}
	DRAW_BLANK_LINE;

	printf("\n");
}


