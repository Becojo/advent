#!/usr/bin/env ruby

program = ARGF.readlines.map do |line|
  cmd, arg = line.strip.split
  [cmd, arg&.to_i]
end

def strength(s)
  s[:x] * s[:cycle]
end

def cycle(s)
  if (s[:cycle] - 20) % 40 == 0
    s[:signals] += strength(s)
  end

  s[:cycle] += 1
end

part_1 = program.reduce({ x: 1, cycle: 1, signals: 0 }) do |s, (cmd, arg)|
  s.tap do
    case cmd
    when "addx"
      cycle(s)
      cycle(s)
      s[:x] += arg
    when "noop"
      cycle(s)
    end
  end
end

puts part_1[:signals]

def draw(s)
  cycle = s[:cycle]
  x = cycle % 40
  y = cycle / 40

  return if y >= 6

  sprite = ("###".ljust(40, " ")).chars.rotate(-s[:x])

  s[:crt][y][x] = sprite[x]
  s[:cycle] += 1
end

crt = 6.times.map { "." * 40 }

part_2 = program.reduce({ x: 0, cycle: 0, crt: crt }) do |s, (cmd, arg)|
  s.tap do
    case cmd
    when "addx"
      draw(s)
      draw(s)
      s[:x] += arg
    when "noop"
      draw(s)
    end
  end
end

puts part_2[:crt].join("\n")
