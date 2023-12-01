input = ARGF.read.split

puts input.map { _1.scan(/\d/).values_at(0, -1).join.to_i }.sum

digits = {
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}

puts input.map { |line|
  line.scan(/(?=(\d|#{digits.keys.join(?|)}))/).values_at(0, -1).flatten.map{digits[_1]||_1}.join.to_i
}.sum
