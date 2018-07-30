#!/usr/bin/env ruby

require_relative "solver"
require_relative "utils"

grid = parse(ARGF)

if !solve(grid)
	puts "KO"
	exit
end

puts get_ascii_table(grid)

