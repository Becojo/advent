# frozen_string_literal: true

input = File.read('3').lines.map(&:strip).map(&:chars)
$input = input

pos = [0, 0]
count = 0

while pos[1] < input.size
  if input[pos[1]][pos[0] % input[0].size] == '#'
    count += 1
  end

  pos = [pos[0] + 3, pos[1] + 1]
end

puts count

def count((dx, dy))
  pos = [0, 0]
  count = 0

  while pos[1] < $input.size
    if $input[pos[1]][pos[0] % $input[0].size] == '#'
      count += 1
    end

    pos = [pos[0] + dx, pos[1] + dy]
  end

  count
end

puts count([1, 1]) * count([3, 1]) * count([5, 1]) * count([7, 1]) * count([1, 2])
