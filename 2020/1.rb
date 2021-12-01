# frozen_string_literal: true

input = File.readlines('1').map(&:to_i)

input.combination(2).each do |x|
  if x.reduce(:+) == 2020
    puts x.reduce(:*)
    break
  end
end

input.combination(3).each do |x|
  if x.reduce(:+) == 2020
    puts x.reduce(:*)
    break
  end
end
