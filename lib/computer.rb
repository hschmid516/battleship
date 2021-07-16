require './lib/board'
require './lib/cell'

class Computer
  attr_reader :board_size

  def initialize(board_size)
    @board_size = board_size
  end

  def random_coords(ship, board)
    coords = board.cells.keys.sample(ship.length)

    if board.valid_placement?(ship, coords) == false
      coords = board.cells.keys.sample(ship.length) until
        board.valid_placement?(ship, coords) == true
      coords
    end
  end

  def com_board
    cruiser = Ship.new(cruiser, 3)
    submarine = Ship.new(submarine, 2)
    board = Board.new(board_size)
    # require 'pry'; binding.pry

    board.place(cruiser, random_coords(cruiser, board))
    board.place(submarine, random_coords(submarine, board))
    board
  end

  def com_speaks
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The Cruiser is three units long and the Submarine is two units long.'
  end

  # def take_shot
  #
  # end
end
