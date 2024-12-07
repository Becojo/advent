input = ARGF.readlines.map do |line|
  total, *values = line.scan(/\d+/).map(&:to_i)
  [total, values]
end

def solve(lines, operators)
  lines.map do |(total, values)|
    ok = operators.repeated_permutation(values.size - 1).any? do |ops|
      total == ops.zip(values.drop(1)).reduce(values.first) do |result, (x, op)|
        result.send(x, op)
      end
    end

    if ok
      total
    else
      0
    end
  end.sum
end

class Integer
  def concat(other)
    (to_s + other.to_s).to_i
  end
end

puts solve(input, [:*, :+])
puts solve(input, [:*, :+, :concat])
