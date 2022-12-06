#!/usr/bin/env ruby

crates, moves = ARGF.read.split("\n\n")

moves = moves.lines.map do |move|
  _, count, _, from, _, to = move.split

  [count.to_i, from.to_i, to.to_i]
end

bins = []

crates = crates.lines.map do |line|
  line.scan(/(\[.\]|   )\s/).each.with_index do |(value), i|
    bin = value.gsub(/[^A-Z]/, '')
    bins[i] ||= []
    bins[i] << bin unless bin.empty?
  end
end

moves.each do |(count, from, to)|
  stack = bins[from - 1][0...count]
  stack.reverse! unless ENV['part'] == '2'
  bins[to-1] = stack + bins[to-1]
  bins[from - 1][0...count] = []
end

puts bins.map(&:first).join
