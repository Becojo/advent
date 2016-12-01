steps = STDIN.read.strip.split(', ').map { |x| [x[0], x[1..-1].to_i] }
pos = [0, 0]
dir = 0
directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]

done = false

steps.each do |(d, step)|
  dir += 1 if d == 'R'
  dir -= 1 if d == 'L'

  pos[0] += step * directions[dir % directions.size][0]
  pos[1] += step * directions[dir % directions.size][1]
end

puts pos.map(&:abs).reduce(:+)
