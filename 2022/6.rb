input = ARGF.read.strip

def find(input, n)
  input.size.times do |i|
    if input[i...i+n].chars.uniq.size == n
      return i + n
    end
  end
end


puts find(input, 4)
puts find(input, 14)
