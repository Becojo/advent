input = ARGF.read

rules, updates = input.split("\n\n")
rules = rules.split.map { _1.split(?|) }
updates = updates.split.map { _1.split(?,) }

def ordered(rules, update)
  rules.all? do |rule|
    next true unless (rule & update).size == rule.size

    a, b = rule.to_a
    update.index(a) < update.index(b)
  end
end

def fix(rules, update)
  rules.each do |rule|
    next unless (rule & update).size == rule.size

    a, b = rule.to_a
    ai, bi = update.index(a), update.index(b)
    update[ai], update[bi] = update[bi], update[ai] if ai > bi
  end

  update
end

part1 = updates.map do |update|
  next 0 unless ordered(rules, update)

  update[update.size / 2].to_i
end.sum

puts part1

part2 = updates.map.with_index do |update, i|
  next 0 if ordered(rules, update)

  update = fix(rules, update) until ordered(rules, update)
  update[update.size / 2].to_i
end.sum

puts part2
