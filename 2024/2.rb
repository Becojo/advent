input = ARGF.readlines

safe = 0
lines = {}
input.each.with_index do |line, i|
    levels = line.split.map(&:to_i)
    diffs = levels.zip(levels.drop(1)).map { |(a, b)|  b - a rescue nil}.uniq.compact

    is_safe = diffs.all? { |c| (-3...0).include?(c) } || diffs.all? { |c| c > 0 && (0..3).include?(c) }
    safe += 1 if is_safe
    lines[i] = is_safe
end

puts safe

input.each.with_index do |line, i|
    levels = line.split.map(&:to_i)
    next if lines[i]

    levels.size.times do |i|
        new_levels = levels.dup
        new_levels.delete_at(i)
        diffs = new_levels.zip(new_levels.drop(1)).map { |(a, b)|  b - a rescue nil}.uniq.compact
        is_safe = diffs.all? { |c| (-3...0).include?(c) } || diffs.all? { |c| c > 0 && (0..3).include?(c) }
        next unless is_safe

        safe += 1
        break
    end
end

puts safe
