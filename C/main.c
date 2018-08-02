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

	printf("Your grid ;\n");

	dump_table(grid);

	if (!solve(grid, 0, 0))
	{
		printf("your grid cannot be solved\n");
		dump_table(grid);
		return -1;
	}

	printf("solved grid ;\n");

	dump_table(grid);

	free(grid);

	return 0;
}
