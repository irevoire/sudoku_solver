package dumb

import (
	"sudoku"
)

var SIZE_OF_SUDOKU byte = sudoku.SIZE_OF_SUDOKU
var UdefVal byte = sudoku.UdefVal

func find_cell(grid []byte, xp, yp byte) (finished bool, x, y byte) {
	x, y = xp, yp
	for ; y < SIZE_OF_SUDOKU; y++ {
		for ; x < SIZE_OF_SUDOKU; x++ {
			if grid[sudoku.HASH(x, y)] == UdefVal {
				finished = false
				return
			}
		}
		x = 0
	}

	finished = true
	return
}

func include(grid []byte, x, y, value byte) bool {
	for n := byte(0); n < SIZE_OF_SUDOKU; n++ {
		switch {
		case grid[sudoku.HASH(n, y)] == value:
			return true
		case grid[sudoku.HASH(x, n)] == value:
			return true
		case grid[sudoku.HASH_BLOC(x, y, n)] == value:
			return true
		}
	}
	return false
}

func Solve(grid []byte, x, y byte) bool {
	var finished bool

	if finished, x, y = find_cell(grid, x, y); finished {
		return true
	}

	for i := byte(1); i <= SIZE_OF_SUDOKU; i++ {
		if include(grid, x, y, i) {
			continue
		}

		grid[sudoku.HASH(x, y)] = i

		if x == (SIZE_OF_SUDOKU - 1) {
			if Solve(grid, 0, y + 1) {
				return true
			}
		} else {
			if Solve(grid, x + 1, y) {
				return true
			}
		}
	}

	// we are going to backtrack
	grid[sudoku.HASH(x, y)] = UdefVal

	return false

}

