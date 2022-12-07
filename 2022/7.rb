#!/usr/bin/env ruby

class Fs
  attr_accessor :input

  def initialize(input:)
    @input = input
    @pwd = []
    @nodes = Hash.new { |h,k| h[k] = 0 }
  end

  def cd(path)
    if path == '..'
      @pwd.pop
    else
      @pwd << path
    end
  end

  def node(name, size)
    @pwd.size.times.each do |i|
      path = @pwd[0..i].join("/")
      @nodes[path] += size
    end
  end

  def call
    input.split('$').drop(1).map do |block|
      command, *lines = block.lines
      bin, arg = command.split

      case bin
      when "cd"
        cd(arg)
      when "ls"
        lines.each do |line|
          type, name = line.split
          if type != "dir"
            node(name, type.to_i)
          end
        end
      end
    end

    part_1 = @nodes.values.select do |size|
      size <= 100000
    end.sum

    space_needed = 30000000 - (70000000 - @nodes["/"])
    part_2 = @nodes.values.keep_if do |size|
      size >= space_needed
    end.sort.first

    puts part_1, part_2
  end
end

input = ARGF.read

Fs.new(input: input).call
