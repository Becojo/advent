#!/usr/bin/env ruby

input = ARGF.readlines


cards = input.map do |line|
  winning, mines = line.split(':')[1].split('|').map(&:split)
  point = 0

  (winning & mines).each do |card|
    if point == 0
      point = 1
    else
      point *= 2
    end
  end

  point
end

puts cards.sum

copies = Hash.new { |h, k| h[k] = 0 }
cards = input.map.with_index do |line, i|
  winning, mines = line.split(':')[1].split('|').map(&:split)
  copies[i] = 1
  (winning & mines).size
end

cards.each.with_index do |point, index|
  copies[index].times do
    (index + 1..index + point).to_a.each do |i|
      copies[i] += 1
    end
  end
end

puts copies.values.sum
