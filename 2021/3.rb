input = File.readlines('3').map(&:strip)

x = input.map(&:chars).transpose.map do |bits|
  bits.map(&:to_i).reduce(:+) > input.size / 2 ? "1" : "0"
end.join.to_i(2)

puts (~x & 0b111111111111) * x
