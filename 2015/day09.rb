require 'set'

cities = Set.new
dist_mat = Hash[STDIN.read.lines.map { |line|
  a, _, b, _, dist = line.strip.split(' ')
  dist = dist.to_i
  cities << a << b
  [[a, b].sort, dist]
}]

values = cities.to_a.permutation.map { |order|
  (order.size-1).times.map { |i|
    dist_mat[order.drop(i).take(2).sort]
  }.reduce(:+)
}

puts values.minmax
