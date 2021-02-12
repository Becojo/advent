# frozen_string_literal: true

input = File.readlines('9').map(&:to_i)

preamble_size = 25
preamble = input[0...preamble_size]
found = nil

input[preamble_size..-1].each.with_index do |value, index|
  unless input[index...(index + preamble_size)].combination(2).map(&:sum).include?(value)
    found = value
    break
  end
end

puts found

input.each.with_index do |_, i|
  (i...input.size).each do |j|
    s = input[i..j].sum

    if s == found
      puts input[i..j].minmax.sum
      exit
    end

	if s > found
      break
    end
  end
end
