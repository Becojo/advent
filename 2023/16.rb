MAP = ARGF.readlines.map{_1.strip.chars}
TILES = Hash.new { |h, k| h[k] = Set.new }

class Beam
  def initialize(x, y, dx, dy)
    @x = x
    @y = y
    @dx = dx
    @dy = dy
  end

  def update
    if out_of_bounds? || TILES[[@x, @y]].include?([@dx, @dy])
      kill!
      return
    end

    TILES[[@x, @y]] << [@dx, @dy]

    case current_tile
    when "-"
      if vertical?
        BEAMS << self.class.new(@x-1, @y, -1, 0)
        @dx = 1
        @dy = 0
      end
    when "|"
      if horizontal?
        BEAMS << self.class.new(@x, @y-1, 0, -1)
        @dx = 0
        @dy = 1
      end
    when "/"
      @dx, @dy = -@dy, -@dx
    when "\\"
      @dx, @dy = @dy, @dx
    end

    @x += @dx
    @y += @dy
  end

  def current_tile
    MAP[@y][@x]
  end

  def vertical?
    @dx == 0
  end

  def horizontal?
    @dy == 0
  end

  def out_of_bounds?
    @x < 0 || @y < 0 || @x >= MAP.first.size || @y >= MAP.size
  end

  def kill!
    BEAMS.delete(self)
  end
end


if ENV['START_X']
  START_X = ENV['START_X'].to_i
  START_Y = ENV['START_Y'].to_i
  START_DX = ENV['START_DX'].to_i
  START_DY = ENV['START_DY'].to_i
else
  START_X = 0
  START_Y = 0
  START_DX = 1
  START_DY = 0
end

BEAMS = [Beam.new(START_X, START_Y, START_DX, START_DY)]
BEAMS.each(&:update) until BEAMS.empty?

part1 = TILES.values.select(&:any?).size

puts part1
