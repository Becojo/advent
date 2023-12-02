input = ARGF.readlines.map do |line|
  game, *draws = line.gsub(',', '').split(/[:;]/)
  { id: game.split.last.to_i, draws: draws.map{_1.split.each_slice(2).map(&:reverse).to_h.transform_values!(&:to_i)} }
end

bag = {
  # only 12 red cubes, 13 green cubes, and 14 blue cubes
  'red' => 12,
  'green' => 13,
  'blue' => 14
}

part1 = input.select { |game|
  game[:draws].all? { |draw|
    draw.all? { |color, count|
      bag[color] >= count
    }
  }
}.map { _1[:id] }.sum

puts part1

part2 = input.map { |game|
  game[:draws].reduce({}) { |bag, draw|
    draw.each { |color, count|
      bag[color] = [bag[color] || 0, count].max
    }
    bag
  }.values.reduce(:*)
}.sum

puts part2
