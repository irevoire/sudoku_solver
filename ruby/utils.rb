def parse input
	grid = Array.new(SIZE_OF_SUDOKU) { Array.new(SIZE_OF_SUDOKU) }

	y = 0
	input.each_line do | l |
		x = 0
		tab = l.split(",")
		tab.each do | el |
			if el.strip == "_"
				grid[y][x] = nil
			else
				grid[y][x] = el.to_i
			end
			x += 1
		end
		y += 1
	end

	return grid
end

def dump_table grid
	for i in 0..(SIZE_OF_SUDOKU * 4 + 2)
		print "_"
	end
	puts

	y = 0
	for row in grid
		print "|"
		x = 0
		for el in row
			print " " 
			if el == nil
				print "\e[31;1mU\e[m"
			else
				print "\e[32;1m" + el.to_s + "\e[m"
			end
			print " |"
			x += 1
			print " " if x % 3 == 0
		end
		y += 1
		puts if y % 3 == 0
		puts
	end
	for i in 0..(SIZE_OF_SUDOKU * 4 + 2)
		print "_"
	end
	puts
end


