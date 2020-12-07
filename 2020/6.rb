# frozen_string_literal: true

input = File.read('6').split("\n\n")

puts input.map { |group|
  group.gsub(/[^a-z]/, '').chars.uniq.size
}.sum

puts input.map { |group|
  group.lines.map(&:strip).map(&:chars).reduce(:&).size
}.sum
