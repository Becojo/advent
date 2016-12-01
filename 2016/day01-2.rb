require 'set'

steps = STDIN.read.strip.split(', ').map { |x| [x[0], x[1..-1].to_i] }
pos = [0, 0]
dir = 0
directions = [[0, 1], [1, 0], [0, -1], [-1, 0]]
cases = Set.new
done = false

cases << [0, 0]

steps.each do |(d, step)|
  dir += 1 if d == 'R'
  dir -= 1 if d == 'L'

  step.times do |i|
    pos[0] += directions[dir % directions.size][0]
    pos[1] += directions[dir % directions.size][1]

    if cases.include?(pos)
      done = true
      break
    end

    cases << pos
  end

  break if done
end

puts pos.map(&:abs).reduce(:+)
