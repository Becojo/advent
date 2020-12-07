# frozen_string_literal: true

input = File.readlines('5')

c = input.map do |code|
  row = code[0...7].tr('FB', '01').to_i(2)
  col = code[7..10].tr('RL', '10').to_i(2)

  row * 8 + col
end

puts c.max

a, b = c.minmax

puts ((a..b).to_a - c)
