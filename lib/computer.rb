require './lib/board'
require './lib/cell'
require './lib/player'


class Computer < Player
  attr_reader :board_size,
              :com_board,
              :shot_square,
              :ships

  def initialize(board_size)
    @board_size  = board_size
    @com_board   = Board.new(board_size)
    @ships       = []
    @shot_square = nil
  end

  def random_coords(ship, board)
    coords = @com_board.cells.keys.sample(ship.length)

    if @com_board.valid_placement?(ship, coords) == false
      coords = @com_board.cells.keys.sample(ship.length) until
        @com_board.valid_placement?(ship, coords) == true
    end
    coords
  end

  def get_ships(ships)
    @ships = ships
  end

  def com_placement
    @ships.each do |ship|
      @com_board.place(ship, random_coords(ship, @com_board))
    end
    system "clear"
    system "cls"
    puts 'I have laid out my ships on the grid.'
    # sleep 2
  end

  def turns(player)
    @shot_square = player.p_board.cells.keys.sample(1).join
    if player.p_board.cells[@shot_square].fired_upon? == true
      @shot_square = player.p_board.cells.keys.sample(1).join until
        player.p_board.cells[@shot_square].fired_upon? == false
    end
    player.p_board.cells[@shot_square].fire_upon
    player.p_board.cells[@shot_square].render
  end

  def hit_check(player)
    if player.p_board.cells[@shot_square].render == "X" ||
        player.p_board.cells[@shot_square].render == "H"
      puts "My shot on #{shot_square} was a hit!"
    else
      puts "My shot on #{shot_square} was a miss!"
    end

    if player.p_board.cells[@shot_square].render == "X"
      puts "I sunk a ship!"
    end
  end
end
