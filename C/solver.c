#include "utils.h"

static int find_cell(char *grid, int *x, int *y)
{
	for (; *y < SIZE_OF_SUDOKU; (*y)++)
	{
		for (; *x < SIZE_OF_SUDOKU; (*x)++)
		{
			if (grid[HASH(*x, *y)] == -1)
				return 0;
		}
		*x = 0;
	}

	*x = *y = -1;

	return 1;
}

static inline int include(char *grid, int x, int y, char value)
{
	for (int n = 0; n < SIZE_OF_SUDOKU; n++)
	{
		if (grid[HASH(n, y)] == value)
			return 1;
		if (grid[HASH(x, n)] == value)
			return 1;
		/*
		   if (grid[HASH_COL(x, n)] == value)
			return 1;
		 */
		if (grid[HASH_BLOC(x, y, n)] == value)
			return 1;
	}

	return 0;
}

int solve(char *grid, int x, int y)
{
	if (find_cell(grid, &x, &y))
		return 1;

	for (int i = 1; i <= SIZE_OF_SUDOKU; i++)
	{
		if (include(grid, x, y, i))
			continue;

		grid[HASH(x, y)] = i;

		if (x == (SIZE_OF_SUDOKU - 1))
		{
			if (solve(grid, 0, y + 1))
				return 1;
		}
		else 
		{
			if (x & 2)
			{
				printf("\e[14A");
				dump_table(grid);
			}

			if (solve(grid, x + 1, y))
				return 1;
		}
	}

	// we are going to backtrack
	grid[HASH(x, y)] = -1;

	return 0;
}
