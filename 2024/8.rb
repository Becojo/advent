input = ARGF.read
by_freq = {}
antinodes = {}
lines = input.split.each.with_index do |line, y|
  line.chars.each.with_index do |char, x|
    next if char == "."
    by_freq[char] ||= []
    by_freq[char] << [x, y]
  end
end
width = lines.first.size
height = lines.size

by_freq.each do |freq, points|
  points.combination(2).each do |((x1, y1), (x2, y2))|
    dx = (x2 - x1)
    dy = (y2 - y1)
    a1 = [x2 + dx, y2 + dy]
    a2 = [x1 - dx, y1 - dy]
    antinodes[a1] = 1
    antinodes[a2] = 1
  end
end

part1 = antinodes.map do |(x, y), _|
  next 0 if x < 0 || y < 0 || x >= width || y >= height
  1
end.sum
puts part1

by_freq.each do |freq, points|
  points.combination(2).each do |((x1, y1), (x2, y2))|
    dx = (x2 - x1)
    dy = (y2 - y1)

    100.times do |i|
      a1 = [x2 + dx * i, y2 + dy * i]
      antinodes[a1] = 1
      a2 = [x1 - dx * i, y1 - dy * i]
      antinodes[a2] = 1
    end
  end
end

part2 = antinodes.map do |(x, y), _|
  next 0 if x < 0 || y < 0 || x >= width || y >= height
  1
end.sum
puts part2
