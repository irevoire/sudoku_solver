package dumb

import (
	"fmt"
	"os"
	"bufio"
	"strings"
)

const UdefVal byte = 0xff
const SIZE_OF_SUDOKU byte = 9

func HASH(x, y byte) byte {
	return x * 9 + y;
}

func HASH_BLOC(x, y, n byte) byte {
	xp := (((x / 3) * 3) + (n % 3)) * 9
	yp := ((y / 3) * 3) + (n / 3)

	return xp + yp
}
func DumpTable(grid []byte) {
	fmt.Println(strings.Repeat("_", 9 * 4 + 2))

	for y := byte(0); y < 9; {
		fmt.Print("|")

		for x := byte(0); x < 9; {
			fmt.Print(" ")
			if grid[HASH(x, y)] == UdefVal {
				fmt.Print("\x1b[31;1mU\x1b[m")
			} else {
				fmt.Printf("\x1b[32;1m%d\x1b[m", grid[HASH(x, y)])
			}
			fmt.Print(" |")

			x++

			if x % 3 == 0 {
				fmt.Print(" ")
			}
		}
		fmt.Print("\n")
		y++

		if y % 3 == 0 {
			fmt.Println("\x1b[2K")
		}
	}
	fmt.Println(strings.Repeat("_", 9 * 4 + 2))
}

func Parse(input *os.File) (grid []byte) {
	grid = make([]byte, 100)

	// We'll use this scanner to read the input line by line
	scanner := bufio.NewScanner(input)

	y := byte(0)

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
				grid[HASH(byte(x), y)] = UdefVal;
			} else if c < '0' || c > '9' {
				goto error
			} else {
				grid[HASH(byte(x), y)] = c - '0';
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
