require 'canal'

input = STDIN.read.lines.map(&canal.split.map(&:to_i).sort).transpose.flatten.each_slice(3)

puts input.map { |(a, b, c)|
  a + b > c ? 1 : 0
}.reduce(:+)
