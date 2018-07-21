#!/usr/bin/env ruby

require 'io/console'

require_relative "../ruby/utils"
require_relative "../ruby/solver"


puts "You'll can now enter your own sudoku grid ;"
puts "<SPC> is used to set an unknow cell"
puts "<1-9> to set a number"
puts "<hjkl or arrow key or abcd> to move on the grid"
puts "<ctrl + d> to say you finished entering the grid"
puts "<q or ctrl + c> to exit"
puts

grid = Array.new(9) { Array.new(9) }

dump_table grid
print "\e[14A"

for i in 0..(9 * 4 + 2)
	print "_"
end
puts

x = 0
y = 0
print "\e[2C"
while true
	input = STDIN.getch

	# quit
	exit if ["q", "\x03"].include?(input)

	if [0x27, 0x91].include?(input)
		redo
	end
	# Finish
	if ["f", "\x04"].include?(input)
		break

	# left
	elsif ["h", "D", "\177"].include?(input) and x > 0
		print "\e[4D"
		print "\e[1D" if x % 3 ==  0
		x -= 1

	# right
	elsif ["l", "C", " ", "\t", 0x4d].include?(input) and x <= 9
		x += 1
		print "\e[6C"
		print "\e[1C" if x % 3 ==  0

	# down
	elsif ["k", "A"].include?(input) and y > 0
		print "\e[1A"
		print "\e[1A" if y % 3 ==  0
		y -= 1

	# up
	elsif ["j", "B"].include?(input) and y <= 9
		y += 1
		print "\e[1B"
		print "\e[1B" if y % 3 ==  0

	# either a number or nothing
	else
		n = input.to_i

		if n == 0 # mean to_i failed or user gave 0 which is not possible
			print "\e[2D"
			redo
		end
		print "\e[32;1m#{n}\e[m"
		print "\e[1C"
		grid[y][x] = n
		x += 1
		print "\e[1C" if x % 3 ==  0
	end

	if x >= 9
		x = 0
		y += 1
		puts if y % 3 == 0
		puts "\e[2C"
	end
end

(y..14).each { | a | puts }

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
