# frozen_string_literal: true

require 'set'

input = File.read('7').lines
count = 0
bags = {}

input.each do |line|
  color, content = line.split(' contain ')

  color.sub!(' bags', '')

  if content['no other bags']
    bags[color] = []
  else
    bags[color] = content.split(/\s*,\s*/).map do |bag|
      [
        bag.to_i,
        bag.sub(/\d+ (.*)bags?.?/, '\1').strip
      ]
    end
  end
end

$colors = bags.keys
$bags = bags

def contains_shinygold?(color, visited=Set.new)
  if visited.include?(color)
    return false
  end

  if color == 'shiny gold'
    true
  else

    ($bags[color] or []).any? do |(_, c)|
      contains_shinygold?(c, visited + [color])
    end
  end
end

c = $colors.count { |c|
  contains_shinygold?(c)
}

puts c - 1

def count_bags(color, count=0, visited=Set.new)
  if $bags[color].size == 0
    return 1
  end

  1 + $bags[color].map do |(count, other)|
    count * count_bags(other)
  end.sum
end

puts count_bags('shiny gold') - 1
