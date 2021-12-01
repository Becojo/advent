xs = File.readlines('1').map(&:to_i)

# part 1
puts xs.zip(xs.drop(1)).select { |(a,b)| b > a if b }.size

# part 2
trios = xs.zip(xs.drop(1), xs.drop(2)).select(&:all?).map { |m| m.reduce(:+) }
puts trios.zip(trios.drop(1)).select { |(a,b)| b > a if b }.size
