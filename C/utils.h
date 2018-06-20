#pragma once

#include <stdio.h>

#define SIZE_OF_SUDOKU 9
#define SIZE_OF_BLOCK 3

#define HASH(x, y) \
	((x) * 10 + (y))

#define HASH_BLOC(x, y, n) \
	( (((x) / 3 * 3) + (n / 3)) * 10 + (((y) / 3 * 3) + (n % 3)) )

char *parse(FILE *input, char *grid);

void dump_table(char *grid);
