input = STDIN.read.strip.lines.map(&:strip)

sum = 0
sum2 = 0

def check(str)
  x = str[/(.)(.)\2\1/]
  x && x[1] != x[-1]
end

def check2(hyper, outside)
  outside.scan(/(?=([a-z])([a-z])(\1))/).each { |(a, b)|
    if a != b && hyper[b + a + b]
      return true
    end
  }

  false
end

input.each do |ip|
  parts = ip.split(/[\[\]]/)

  hypernet = parts.select.each_with_index { |_, i| i.odd? }.join(',')
  supernet = parts.select.each_with_index { |_, i| i.even? }.join(',')

  sum2 += 1 if check2(hypernet, supernet)

  is_okay = hypernet.all? do |p|
    !check(p)
  end

  next unless is_okay

  is_okay = supernet.any? do |p|
    check(p)
  end

  sum += 1 if is_okay

end

puts sum
puts sum2
