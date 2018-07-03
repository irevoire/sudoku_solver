#!/usr/bin/env ruby

require 'io/console'

require_relative "../ruby/utils"
require_relative "../ruby/solver"


puts "You'll can now enter your own sudoku grid ;"
puts "<SPC> is used to set an unknow cell"
puts "<1-9> to set a number"
puts "<q> to exit"
puts

grid = Array.new(9) { Array.new(9) }

dump_table grid
print "\e[14A"

for i in 0..(9 * 4 + 2)
	print "_"
end
puts

y = 0
while y < 9
	print "|"
	x = 0
	while x < 9
		print "\e[1C"

		input = STDIN.getch

		if input == "\n"
			puts "blabla"
		end

		#         q    ctrl C
		exit if ["q", "\u0003"].include?(input)

		#   h   left  backspace
		if ["h", "D", "\177"].include?(input) and x > 0
			print "\e[4D"
			print "\e[1D" if x % 3 ==  0
			x -= 1
		end

		#   l   broken   tab
		if ["l", "C", "\t", 0x4d].include?(input) and x < 8
			x += 1
			print "\e[4C"
			print "\e[1C" if x % 3 ==  0
		end

		#   k    down
		if ["k", "A"].include?(input) and y > 0
			print "\e[1A"
			print "\e[1A" if y % 3 ==  0
			y -= 1
		end

		#   j    up
		if ["j", "B"].include?(input) and y < 8
			y += 1
			print "\e[1B"
			print "\e[1B" if y % 3 ==  0
		end

		if input == " "
			print "\e[33;1mU\e[m"
			grid[y][x] = nil
		else
			n = input.to_i

			if n == 0 # mean to_i failed or user gave 0 which is not possible
				print "\b"
				redo
			end
			print "\e[32;1m#{n}\e[m"
			grid[y][x] = n
		end

		print " |"
		x += 1
		print " " if x % 3 == 0
	end
	y += 1

	puts
	puts if y % 3 == 0
end
puts
puts

if !check(grid)
	puts "\e[31;1mYour grid is not solvable\e[m\n"
end


# Now the grid is complete, we are gonna save it in some file

puts "What name do you want to give to your grid?"

filename = STDIN.gets.chomp.strip

file = File.open(filename, "w")

for y in 0..8
	for x in 0..8
		n = grid[y][x]
		if n == nil
			file.write "_"
		else
			file.write n
		end
		file.write "," if x != 8
	end
	file.puts
end

file.close
