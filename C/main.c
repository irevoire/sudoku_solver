#include <stdio.h>

#include "solver.h"
#include "utils.h"

int main(void)
{
	char *grid;

	grid = parse(stdin);

	printf("Your grid ;\n");

	dump_table(grid);

#if 0
	dump_table(grid);

	if (!solve(grid))
	{
		printf("your grid cannot be solved\n");
		dump_table(grid);
		exit(1);
	}

	printf("\e[14A");
	printf("solved grid ;\n");

	dump_table(grid);

#endif
	return 0;
}
