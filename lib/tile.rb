require_relative 'vertex'
require 'colorize'

class Tile < Vertex
  attr_reader :x, :y
  attr_accessor :color, :flag

  def initialize(options={})
    @x = options[:x] || 0
    @y = options[:y] || 0
    @color = nil
    @revealed = false
    @flag = false
    super(options)
  end

  def adjacent_bombs
    @neighbors.count {|n, _| n.value}
  end

  def flip
    return if flag
    @revealed = true
    if @value
      raise "BOOM!"
    end

    if adjacent_bombs == 0
      @neighbors.each do |neighbor, _|
        neighbor.flip unless neighbor.revealed or neighbor.flag
      end
    end
  end

  def toggle_flag
    @flag = @flag ^ true
  end

  def to_s
    if @revealed
      if value
        "[B]"
      else
        "[#{adjacent_bombs}]"
      end
    else
      "[ ]"
    end
  end

  def self.tile_from_char(char, idx, idy)
    self.new(x:idx, y:idy, value: (char.upcase=='B' ? true : nil))
  end
end
