input = ARGF.readlines.map do |line|
  line.split(',').map do |pair|
    a, b = pair.split('-').map(&:to_i)

    a..b
  end
end

part_1 = input.select do |(r1, r2)|
  r1.cover?(r2) || r2.cover?(r1)
end.size

part_2 = input.select do |(r1, r2)|
  (r1.to_a & r2.to_a).any?
end.size

puts part_1, part_2
