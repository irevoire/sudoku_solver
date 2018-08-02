#!/usr/bin/env ruby

require_relative "solver"
require_relative "utils"

grid = parse(ARGF)

puts "Your grid ;"

dump_table grid

if !solve(grid)
	puts "your grid cannot be solved"
	dump_table grid
	exit
end

puts "solved grid ;"

dump_table grid
