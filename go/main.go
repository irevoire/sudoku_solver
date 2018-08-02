package main

import (
	"fmt"
	"sudoku"
	"os"
/*
	"runtime"
	"bytes"
*/
)

func main() {
	var grid[]byte

	if len(os.Args) < 2 {
		grid = sudoku.Parse(os.Stdin)
	} else if len(os.Args) == 2 {
		file, err := os.Open(os.Args[1])
		if err != nil {
			fmt.Println(err)
			os.Exit(-2)
		}
		grid = sudoku.Parse(file)
	} else {
		fmt.Println("Error, too much arguments")
		os.Exit(-1)
	}

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

