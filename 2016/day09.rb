def decompress(input)
  output = ''

  until input.empty?
    if input[0] == '('
      ending = input.index(')')
      a, b = input[1..ending-1].join.split('x').map(&:to_i)

      input = input.drop(ending + 1)
      output += (input[0...a] * b).join

      input = input.drop(a)

    else
      output += input.shift
    end
  end

  output.size
end

def decompress2(input)
  return input.size unless input.index('(')

  sum = 0

  until input.empty?
    if input[0] == '('
      ending = input.index(')')
      a, b = input[1..ending-1].join.split('x').map(&:to_i)

      input = input.drop(ending + 1)
      sum += decompress2(input[0...a]) * b

      input = input.drop(a)

    else
      input.shift
      sum += 1
    end
  end

  sum
end

s = STDIN.read.strip

puts decompress(s.chars)
puts decompress2(s.chars)
