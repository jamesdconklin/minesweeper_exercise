require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid

  def initialize(grid)
    @grid = grid
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
          byebug
          down = grid[idy+1][idx]
          curr.connect(right) if right
          curr.connect(down) if down
        end
      end
    end
  end

  def self.from_file(file_name)
    grid = self.grid_from_file(file_name)

    self.connect_grid(grid)
    self.new(grid)
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
