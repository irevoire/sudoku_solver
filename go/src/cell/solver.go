package cell

import (
	"fmt"
	"sudoku"
)

type cellData struct {
	x             byte
	y             byte
	possibilities []byte
	answer        chan byte
}

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

func cellRoutine(grid []byte, x, y byte, c chan cellData) {
	possibilities := []byte{1, 2, 3, 4, 5, 6, 7, 8, 9}
	answer := make(chan byte)
	data := cellData{x, y, possibilities, answer}

	for {
		for _, i := range possibilities {
			if include(grid, x, y, i) {
				possibilities = removeElFromSlice(possibilities, i)
			}
		}
		data.possibilities = possibilities
		c <- data
		res := <-data.answer
		if res != 0 {
			grid[sudoku.HASH(x, y)] = res
			return
		}
	}
}

func blocRoutine(grid []byte, xb, yb byte, c chan bool) {
	ccell := make(chan cellData, 9)
	nb_routine := 0

	// Launch all the sub goroutines
	for xc := byte(0); xc < 3; xc++ {
		for yc := byte(0); yc < 3; yc++ {
			x, y := (xb*3 + xc), (yb*3 + yc)
			if grid[sudoku.HASH(x, y)] == sudoku.UdefVal {
				go cellRoutine(grid, x, y, ccell)
				nb_routine++
			}
		}
	}
	for {
		tab := make([]cellData, nb_routine)
		for i := 0; i < nb_routine; i++ {
			tab[i] = <-ccell
		}

		for _, el := range tab {

		}

		fmt.Println(tab)
		return
	}
}

func Solve(grid []byte) bool {
	cbloc := make(chan bool, 9)

	for x := byte(0); x < 3; x++ {
		for y := byte(0); y < 3; y++ {
			go blocRoutine(grid, x, y, cbloc)
		}
	}

	nbBloc := 9

	for nbBloc > 0 {
		<-cbloc
		nbBloc--
		fmt.Println("A bloc finished")
		sudoku.DumpTable(grid)
	}

	return true

}
