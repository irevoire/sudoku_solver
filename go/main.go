package main

import (
	"fmt"
	"sudoku"
/*
	"runtime"
	"bytes"
*/
)

func main() {
	var grid[]byte = sudoku.Parse()

	sudoku.DumpTable(grid)

	sudoku.DumpTable(grid)

	if !sudoku.Solve(grid) {
		fmt.Println("Your grid cannot be solved")
		sudoku.DumpTable(grid)
		return
	}

	fmt.Printf("\x1b[14A")
	fmt.Println("solved grid ;")

	sudoku.DumpTable(grid)
}

