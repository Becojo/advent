input = ARGF.readlines
map = {}
width = input[0].strip.size
height = input.size
WORD = "XMAS"

input.each.with_index do |line, row|
  line.strip.chars.each.with_index do |char, col|
    map[[row, col]] = char
  end
end

def count(map, row, col)
  down = WORD.size.times.map { [row, col + _1] }
  up = WORD.size.times.map { [row, col - _1] }
  right = WORD.size.times.map { [row + _1, col] }
  left = WORD.size.times.map { [row - _1, col] }
  upright = WORD.size.times.map { [row + _1, col + _1] }
  upleft = WORD.size.times.map { [row - _1, col + _1] }
  downleft = WORD.size.times.map { [row - _1, col - _1] }
  downright = WORD.size.times.map { [row + _1, col - _1] }

  [
    down,
    up,
    right,
    left,
    upright,
    upleft,
    downleft,
    downright,
  ].map do |dir|
    word = map.values_at(*dir).join
    if word == WORD
      1
    else
      0
    end
  end.sum
end

total = 0
width.times.each do |col|
  height.times.each do |row|
    if map[[row, col]] == "X"
      total += count(map, row, col)
    end
  end
end

puts total

def xmas(map, row, col)
  upright = map[[row - 1, col + 1]]
  upleft = map[[row - 1, col - 1]]
  downleft = map[[row + 1, col - 1]]
  downright = map[[row + 1, col + 1]]

  if [upright, upleft, downleft, downright].any?(&:nil?)
    return 0
  end

  a = [upright, downleft].sort.join
  b = [upleft, downright].sort.join

  if a == b && b == "MS"
    1
  else
    0
  end
end

total = 0
width.times.each do |col|
  height.times.each do |row|
    if map[[row, col]] == "A"
      total += xmas(map, row, col)
    end
  end
end

puts total
