require 'canal'

sizes = STDIN.read.lines.map(&canal.strip.split('x').map(&:to_i))

puts sizes.reduce(0) { |sum, size|
  l, w, h = size
  sides = [l * w, l * h, w * h]
  sum + 2 * sides.reduce(:+) + sides.min
}

puts sizes.reduce(0) { |sum, size|
  sum + 2 * size.sort.take(2).reduce(:+) + size.reduce(:*)
}
