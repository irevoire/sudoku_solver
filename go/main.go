package main

import (
	"fmt"
	"dumb"
	"os"
)

func main() {
	var grid[]byte

	if len(os.Args) < 2 {
		grid = dumb.Parse(os.Stdin)
	} else if len(os.Args) == 2 {
		file, err := os.Open(os.Args[1])
		if err != nil {
			fmt.Println(err)
			os.Exit(-2)
		}
		grid = dumb.Parse(file)
		file.Close()
	} else {
		fmt.Println("Error, too much arguments")
		os.Exit(-1)
	}

	fmt.Println("Your grid ;")
	dumb.DumpTable(grid)

	if !dumb.Solve(grid, 0, 0) {
		fmt.Println("Your grid cannot be solved")
		return
	}

	fmt.Println("solved grid ;")
	dumb.DumpTable(grid)
}

