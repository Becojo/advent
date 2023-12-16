
input = ARGF.read.strip.split(",")

def h(s)
  s.bytes.reduce(0) do |sum, c|
    sum += c
    sum *= 17
    sum % 256
  end
end

part1 = input.map do |part|
  part.bytes.reduce(0) do |sum, c|
    sum += c
    sum *= 17
    sum % 256
  end
end

puts part1.sum

boxes = Hash.new{|h, k| h[k] = {}}

input.zip(part1).each do |cmd, hash|
  label, op, value = cmd.split(/([-=])([0-9]+)?/)
  box = h(label)

  if op == "="
    boxes[box][label] = value.to_i
  end

  if op == "-"
    boxes[box].delete(label)
  end
end

part2 = boxes.flat_map do |i, lenses|
  lenses.map.with_index do |(label, focal), slot|
    [i+1, focal, slot+1].reduce(:*)
  end
end

puts part2.sum
