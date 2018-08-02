package sudoku

import (
	"fmt"
	"os"
	"bufio"
	"strings"
)

const UdefVal byte = 0xff

func HASH(x, y int) int {
	return x * 9 + y;
}

func DumpTable(grid []byte) {
	fmt.Println("dump grid")
}

func Parse(input *os.File) (grid []byte) {
	grid = make([]byte, 100)

	// We'll use this scanner to read the input line by line
	scanner := bufio.NewScanner(input)

	y := 0

	for scanner.Scan() {
		line := scanner.Text()
		data := strings.Split(line, ",")

		if len(data) != 9 {
			fmt.Println("A")
			goto error
		}

		for x, el := range data {
			if len(el) != 1 {
			fmt.Println("B")
				goto error
			}
			c := el[0]
			if (c == '_') {
				grid[HASH(x, y)] = UdefVal;
			} else if c < '0' || c > '9' {
				goto error
			} else {
				grid[HASH(x, y)] = c - '0';
			}
		}

		y++
	}
	return
error:
	fmt.Println("Your grid is invalid: ")
	os.Exit(-3)
	return
}
