require 'canal'

state = Hash[STDIN.read.lines.flat_map.with_index { |line, i|
               line.strip.chars.map.with_index { |x, j|
                 [[i, j], x == '#']
               }
             }]

DELTA = [1, 1, 0, -1, -1].permutation(2).to_a.uniq

def neighboors(state, pos)
  DELTA.map { |delta|
    state[pos.zip(delta).map(&canal.reduce(:+))]
  }.count(&canal)
end

def next_gen(state)
  Hash[state.map { |pos, alive|
    next_val = case neighboors(state, pos)
               when 3
                 true
               when 2..3
                 alive
               else
                 false
               end

    [pos, next_val]
  }]
end

def set_corners(state)
  state[[0, 0]] = true
  state[[99, 0]] = true
  state[[0, 99]] = true
  state[[99, 99]] = true

  state
end

puts 100.times.reduce(state) { |state, _| next_gen(state) }.values.count(&canal)
