#!/usr/bin/env ruby

class Monkey
  attr_accessor :inspected, :items, :test

  def initialize(items, operation, test, if_true, if_false)
    @items = items
    @test = test
    @outcome = { true => if_true, false => if_false }
    @inspected = 0
    @lcm = 0

    instance_eval(%Q{
      def operation(old)
        (#{operation}) / 3
      end
    })
  end

  def inspect_items(monkeys)
    return {} if @items.empty?

    @inspected += @items.size

    @items.each do |item|
      new_item = operation(item)
      i = @outcome[new_item % @test == 0]
      monkeys[i].items << new_item
    end

    @items = []
  end
end

monkeys = ARGF.read.split("\n\n").map do |monkey|
  _, items, operation, test, if_true, if_false = monkey.lines
  operation = operation.split("= ").last

  Monkey.new(
    items.split(": ").last.split(", ").map(&:to_i),
    operation,
    test[/\d+/].to_i,
    if_true[/\d+/].to_i,
    if_false[/\d+/].to_i
  )
end

20.times do |round|
  monkeys.each do |monkey|
    monkey.inspect_items(monkeys)
  end
end

pp monkeys.map(&:inspected).max(2).reduce(:*)
