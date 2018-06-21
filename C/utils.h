#pragma once

#include <stdio.h>
#include <stdlib.h>

#define SIZE_OF_SUDOKU 9
#define SIZE_OF_BLOCK 3

static inline int HASH(int x, int y)
{
	return x * 10 + y;
}

static inline int HASH_BLOC(int x, int y, int n)
{
	div_t ndiv = div(n, 3);

	const int xp = (x / 3 * 3 + ndiv.quot) * 10;
	const int yp = y / 3 * 3 + ndiv.rem;

	return xp + yp;
}

char *parse(FILE *input, char *grid);

void dump_table(char *grid);
