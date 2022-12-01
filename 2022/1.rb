#!/usr/bin/env ruby

elves = File.read('1').split("\n\n").map{_1.split.map(&:to_i)}

sums = elves.map(&:sum).sort.reverse

puts sums[0]
puts sums[0...3].sum
