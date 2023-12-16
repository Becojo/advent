input = ARGV[0]
map = File.readlines(input).map{_1.strip.chars}
height = map.size
width = map[0].size
points = []

width.times do |x|
  points << [[x, 0], [0, 1]]
  points << [[x, height - 1], [0, -11]]
end

height.times do |y|
  points << [[0, y], [1, 0]]
  points << [[width - 1, y], [-1, 0]]
end

part2 = points.map do |(x, y), (dx, dy)|
  `START_X=#{x} START_Y=#{y} START_DX=#{dx} START_DY=#{dy} ruby 16.rb #{input}`.to_i
end

puts part2.max
