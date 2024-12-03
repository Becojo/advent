input = ARGF.read

part1 = input.scan(/mul\(\d+,\d+\)/).map do |match|
    match.scan(/\d+/).map(&:to_i).reduce(:*)
end.sum

puts part1


flag = true
part2 = input.scan(/(mul\(\d+,\d+\)|(do|don't)\(\))/).map do |(a, b)|
  flag = true if b == "do"
  flag = false if b == "don't"

  if flag && b.nil?
    a.scan(/\d+/).map(&:to_i).reduce(:*)
  else
    0
  end
end.sum

puts part2
