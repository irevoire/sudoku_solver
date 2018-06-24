#!/usr/bin/env ruby

require 'io/console'

require_relative "../ruby/utils"


puts "You'll can now enter your own sudoku grid ;"
puts "<SPC> is used to set an unknow cell"
puts "<1-9> to set a number"
puts "<s> to exit"
puts

grid = Array.new(9) { Array.new(9) }

dump_table grid
print "\e[14A"

for i in 0..(9 * 4 + 2)
	print "_"
end
puts

for y in 0..8
	print "|"
	for x in 0..8
		print " " 
		print "\e[41;1m \e[m\b"

		input = STDIN.getch
		exit if input == "s"

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
	puts "\e[2K" if y % 3 == 0
end
for i in 0..(9 * 4 + 2)
	print "_"
end
puts
puts

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








