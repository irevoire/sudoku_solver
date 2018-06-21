#pragma once

#include <stdio.h>

#define SIZE_OF_SUDOKU 9
#define SIZE_OF_BLOCK 3

static inline int HASH(const int x, const int y)
{
	return x * 10 + y;
}

static inline int HASH_BLOC(const int x, const int y, const int n)
{
	const int xp = (x / 3 * 3 + n / 3) * 10;
	const int yp = y / 3 * 3 + n % 3;

	return xp + yp;
}

char *parse(FILE *input, char *grid);

void dump_table(char *grid);
