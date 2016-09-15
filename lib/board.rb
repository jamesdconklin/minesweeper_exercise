require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid
  attr_accessor :cards_left

  def initialize(grid)
    @grid = grid
    @cards_left = 0
    @grid.each do |row|
      row.each do |tile|
        @cards_left += 1 unless tile.value
      end
    end
  end

   def won?
     @cards_left <= 0
   end

  def self.grid_from_file(file_name)
    grid = []
    File.foreach(file_name).with_index do |line, idy|
      row = []
      line.chomp.scan(/./).each.with_index do |char, idx|
        row << Tile.tile_from_char(char, idx, idy)
      end
      grid << row
    end
    grid
  end

  def self.connect_grid(grid)
    0.upto(grid.length-2) do |idy|
      0.upto(grid[idy].length-1) do |idx|
        curr = grid[idy][idx]
        if curr
          right = grid[idy][idx+1]
          down = grid[idy+1][idx]
          down_right = grid[idy+1][idx+1]
          down_left = grid[idy+1][idx-1]
          curr.connect(right) if right
          curr.connect(down) if down
          curr.connect(down_right) if down_right
          curr.connect(down_left) if down_left && idx > 0
        end
      end
    end
  end

  def self.from_file(file_name)
    grid = self.grid_from_file(file_name)

    self.connect_grid(grid)
    self.new(grid)
  end

  def [](pos)
    y,x = pos
    @grid[y][x]
  end

  def toggle_flag(pos)
    self[pos].toggle_flag
  end

  def flip(pos)
    flipped = self[pos].flip
    @cards_left -= flipped
    flipped
  end

  def to_s
    string = ""
    @grid.each do |row|
      row.each do |cell|
        string << (cell ? cell.to_s : '*')
      end
      string  << "\n"
    end
    string
  end

  def render
    puts to_s
  end

end
