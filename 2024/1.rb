input = ARGF.read.lines
ax = []
bx = []

input.each do |line|
    a, b = line.split.map(&:to_i)
    ax << a
    bx << b
end

ax.sort!
bx.sort!

part1 = ax.zip(bx).map do |(a, b)|
    (b - a).abs
end.sum

puts part1

bf = bx.group_by(&:itself).transform_values(&:size)
part2 = ax.map do |a|
    a * bf.fetch(a, 0)
end.sum

puts part2