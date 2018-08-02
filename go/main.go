package main

import (
	"fmt"
	"sudoku"
	"os"
)

func main() {
	var grid[]byte

	if len(os.Args) < 2 {
		fmt.Println("Getting input from stdin")
		grid = sudoku.Parse(os.Stdin)
	} else if len(os.Args) == 2 {
		fmt.Println("Getting input from", os.Args[1])
		file, err := os.Open(os.Args[1])
		if err != nil {
			fmt.Println(err)
			os.Exit(-2)
		}
		grid = sudoku.Parse(file)
		file.Close()
	} else {
		fmt.Println("Error, too much arguments")
		os.Exit(-1)
	}

	fmt.Println("Your grid ;")
	sudoku.DumpTable(grid)

	if !sudoku.Solve(grid, 0, 0) {
		fmt.Println("Your grid cannot be solved")
		sudoku.DumpTable(grid)
		return
	}

	fmt.Println("solved grid ;")
	sudoku.DumpTable(grid)
}

