class Game
  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file_name)
    self.new(Board.from_file(file_name))
  end

  def get_move
    response = nil
    print "Enter a move e.g. flip x,y or flag x,y: "
    until response &
    end  
    end

  end

  def play_move
  end

  def run
  end

  def play_turn
  end

  def parse_pos(pos)
    pos.scan(/\d+/).map(&:to_i)
  end

end
