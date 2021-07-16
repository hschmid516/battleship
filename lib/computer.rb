require './lib/board'
require './lib/cell'

class Computer
  attr_reader :board_size,
              :com_board,
              :cruiser,
              :submarine

  def initialize(board_size)
    @board_size = board_size
    @com_board = com_board
    @cruiser = cruiser
    @submarine = submarine
  end

  def random_coords(ship, board)
    coords = @com_board.cells.keys.sample(ship.length)

    if @com_board.valid_placement?(ship, coords) == false
      coords = @com_board.cells.keys.sample(ship.length) until
        @com_board.valid_placement?(ship, coords) == true
      coords
    end
  end

  def com_placement
    @com_board = Board.new(board_size)
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    # update name to string
    @com_board.place(@cruiser, random_coords(@cruiser, @com_board))
    @com_board.place(@submarine, random_coords(@submarine, @com_board))
  end

  def turns(player)
    shot_square = @com_board.cells.keys.sample(1).join
    # require 'pry'; binding.pry
    while @com_board.cells[shot_square].fired_upon? == true
      shot_square = @com_board.cells.keys.sample(1)
    end
    player.p_board.cells[shot_square].fire_upon
    player.p_board.cells[shot_square].render

  end

  def com_speaks
    system "clear"
    system "cls"
    puts 'I have laid out my ships on the grid.'
    puts 'You now need to lay out your two ships.'
    puts 'The Cruiser is three units long and the Submarine is two units long.'
  end

  # def take_shot
  #
  # end
end
