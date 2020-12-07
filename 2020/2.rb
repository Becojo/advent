input = File.readlines('2').map do |line|
  line.split
end

puts input.select { |(range, letter, password)|
  min, max = range.split('-').map(&:to_i)
  letter = letter[0]
  c = password.count(letter)

  (min..max).include?(c)
}.size

puts input.select { |(range, letter, password)|
  min, max = range.split('-').map(&:to_i)
  letter = letter[0]

  (password[min - 1] == letter) ^ (password[max - 1] == letter)
}.size
