def find_cell(grid, x, y)
	for j in y..8
		for i in x..8
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

	for i in 1..9

		if col.include?(i) || line.include?(i)
			next
		end

		grid[x][y] = i

		if !check(grid)
			next
		end

		if (x == 8)
			if solve(grid, 0, y + 1)
				return true
			end
		else 
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
	for i in 0..8
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

	for y in 0..2
		for x in 0..2
			block = []
			for index in 0..2
				block += grid[(x * 3) + index][(y * 3)..((y + 1) * 3 - 1)]
			end

			block = block.compact
			if block.size != block.uniq.size
				return false
			end
		end
	end

	return true
end
