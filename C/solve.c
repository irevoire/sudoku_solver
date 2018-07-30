#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "solver.h"
#include "utils.h"

int main(void)
{
	char *grid = malloc(100);

	memset(grid, -2, 100);

	parse(stdin, grid);

	if (!solve(grid, 0, 0))
	{
		printf("KO\n");
		return -1;
	}

	char *solved_table = get_ascii_table(grid);
	printf("%s\n", solved_table);
	free(solved_table);

	free(grid);

	return 0;
}
