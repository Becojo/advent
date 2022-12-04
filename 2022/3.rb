#!/usr/bin/env ruby

input = ARGF.read.split
values = (('a'..'z').to_a + ('A'..'Z').to_a).map.with_index { [_1, _2 + 1] }.to_h

part_1 = input.flat_map do |line|
  line.chars
    .each_slice(line.size / 2)
    .reduce(:&)
    .map { values[_1] }
end.sum

puts part_1

part_2 = input.each_slice(3).map do |group|
  values[group.map(&:chars).reduce(:&).first]
end.sum

puts part_2
