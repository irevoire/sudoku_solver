package main

import (
	"fmt"
	"os"

	"sudoku"
	"cell"
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
		file.Close()
	} else {
		fmt.Println("Error, too much arguments")
		os.Exit(-1)
	}

	fmt.Println("Your grid ;")
	sudoku.DumpTable(grid)

	if !cell.Solve(grid) {
		fmt.Println("Your grid cannot be solved")
		return
	}

	fmt.Println("solved grid ;")
	sudoku.DumpTable(grid)
}

