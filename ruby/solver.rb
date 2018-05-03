SIZE_OF_SUDOKU = 9
SIZE_OF_BLOCK = Math.sqrt(SIZE_OF_SUDOKU)


def find_cell(grid, x, y)
	for j in y..(SIZE_OF_SUDOKU - 1)
		for i in x..(SIZE_OF_SUDOKU - 1)
			if grid[i][j] == nil
				return false, i, j
			end
		end
		x = 0
	end

	return true, -1, -1, nil
end

def solve(grid, x = 0, y = 0)
	is_finished, x, y = find_cell(grid, x, y)

	return true if is_finished

	col = grid.map { |l| l[y] }.compact
	line = grid[x].compact

	for i in 1..SIZE_OF_SUDOKU

		if col.include?(i) || line.include?(i)
			next
		end

		grid[x][y] = i

		if !check(grid)
			next
		end

		if (x == (SIZE_OF_SUDOKU - 1))
			if solve(grid, 0, y + 1)
				return true
			end
		else 
			if (x & 2)
				print "\e[0;0H"
				dump_table(grid)
			end

			if solve(grid, x + 1, y)
				return true
			end
		end
	end

	# we are going to backtrack
	grid[x][y] = nil

	return false
end

def check(grid)
	# Here we check if a line or column have the same element twice
	for i in 0..(SIZE_OF_SUDOKU - 1)
		col = grid.map { |l| l[i] }
		line = grid[i]

		# compact remove the nil
		# but we don't use compact! because xe don't want to alter the initial grid
		col = col.compact
		if col.size != col.uniq.size
			return false
		end

		line = line.compact
		if line.compact.size != line.uniq.size
			return false
		end
	end

	for y in 0..(SIZE_OF_BLOCK - 1)
		for x in 0..(SIZE_OF_BLOCK - 1)
			block = []
			for index in 0..(SIZE_OF_BLOCK - 1)
				block += grid[(x * SIZE_OF_BLOCK) + index][(y * SIZE_OF_BLOCK)..((y + 1) * SIZE_OF_BLOCK - 1)]
			end

			block = block.compact
			if block.size != block.uniq.size
				return false
			end
		end
	end

	return true
end
