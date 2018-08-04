package cell

import (
	"fmt"
	"sudoku"
	"time"
)

var finished chan bool

func include(grid []byte, x, y, value byte) bool {
	for n := byte(0); n < sudoku.SIZE_OF_SUDOKU; n++ {
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

func removeElFromSlice(s []byte, el byte) []byte {
	for j, n := range s {
		if n == el {
			s[j] = s[0]
			s = s[1:]
			break
		}
	}
	return s
}

func routine(grid []byte, x, y byte) {
	possibilities := []byte{1, 2, 3, 4, 5, 6, 7, 8, 9}

	for len(possibilities) > 1 {
		//fmt.Println("MOI :", x + y *10)
		for _, i := range possibilities {
			if include(grid, x, y, i) {
				possibilities = removeElFromSlice(possibilities, i)
			}
		}
		time.Sleep(100)
	}

	if len(possibilities) == 0 {
		fmt.Println("Your grid is unsolvable, go fuck yo momma")
		return
	}

	fmt.Println(x, y, "is", possibilities[0])

	finished<-true
	grid[sudoku.HASH(x, y)] = possibilities[0]

}

func Solve(grid []byte) bool {
	finished = make(chan bool, 100)

	nbRoutine := 0

	for x := byte(0); x < 9; x++ {
		for y := byte(0); y < 9; y++ {
			if grid[sudoku.HASH(x, y)] == sudoku.UdefVal {
				nbRoutine++
				go routine(grid, x, y)
			}
		}
	}

	fmt.Println("I'll use", nbRoutine, " goroutines")

	for nbRoutine > 0 {
		<-finished
		nbRoutine--
		fmt.Println("there is still", nbRoutine, " goroutines")
		sudoku.DumpTable(grid)
	}

	return true

}

