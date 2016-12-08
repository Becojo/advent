input = STDIN.read.lines.map(&:strip)

screen = 6.times.map { [0] * 50 }

input.each do |line|
  parts = line.split

  if parts[0] == 'rect'
    x, y = parts[1].split('x').map(&:to_i)

    x.times do |i|
      y.times do |j|
        screen[j][i] = 1
      end
    end
  end

  if line['rotate row']
    y = parts[2].split('=')[1].to_i
    offset = parts[4].to_i

    screen[y] = screen[y].cycle.lazy.drop(50 - offset).take(50).to_a
  end

  if line['rotate column']
    x = parts[2].split('=')[1].to_i
    offset = parts[4].to_i

    values = screen.transpose[x].cycle.lazy.drop(6 - offset).take(6)

    values.each.with_index do |v, i|
      screen[i][x] = v
    end
  end
end

# Part 1
puts screen.flatten.reduce(:+)

# Part 2
puts screen.map(&:join).join("\n").gsub('0',' ')
