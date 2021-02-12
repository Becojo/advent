input = File.read('10').lines.map(&:to_i).sort

input = %w(
16
10
15
5
1
11
7
19
6
12
4
).map(&:to_i).sort

diff = input.zip(input.drop(1))[0...-1].map { |xs| xs.reduce(:-) }

puts (diff.count(-1) + 1) * (diff.count(-3) + 1)

def count(current, values)
  if values.size == 1
    return 1
  end

  puts [current, values].inspect

  sub = values.select { |x| x > current && (x - current) <= 3 }.map { |x|
    count(x, values - [x])
  }

  [1, sub.size].max * sub.reduce(1, :*)
end

puts count(0, input)
