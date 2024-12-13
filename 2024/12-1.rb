input = ARGF.read
map = {}
regions = Hash.new{|h, k| h[k] = [] }
visited = {}

input.split.each.with_index do |line, y|
    line.chars.each.with_index do |char, x|
        map[[x, y]] = char
    end
end

def floodfill(map, p, state = [], c = nil)
    x, y = p
    return unless map[p]
    return if state[p]
    c = map[p] if c.nil?
    return unless map[p] == c
    state[p] = c

    floodfill(map, [x+1, y], state, c)
    floodfill(map, [x-1, y], state, c)
    floodfill(map, [x, y+1], state, c)
    floodfill(map, [x, y-1], state, c)
end

until visited.keys.size == map.keys.size
    p = (map.keys - visited.keys).sample
    state = {}
    floodfill(map, p, state)
    visited.merge!(state)
    regions[map[p]] << state
end

def find_perimeter(region)
    t = Hash.new { |h, k| h[k] = 0 }
    region.keys.each do |p|
        t[p] = -10
    end
    region.keys.each do |(x, y)|
        t[[x+1, y]] += 1
        t[[x-1, y]] += 1
        t[[x, y+1]] += 1
        t[[x, y-1]] += 1
    end

    region.size * t.select { |k, v| v > 0 }.values.sum
end

part1 = 0
regions.map do |r, rs|
    rs.each do |reg|
        part1 += find_perimeter(reg)
    end
end
puts part1
