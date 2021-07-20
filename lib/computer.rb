require './lib/board'
require './lib/player'


class Computer < Player
  attr_reader :board_size,
              :com_board,
              :shot_square,
              :ships,
              :hits


  def initialize(board_size)
    @board_size  = board_size
    @com_board   = Board.new(board_size)
    @ships       = []
    @shot_square = nil
    @hits        = []
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
    @ships = ships.map { |ship| Ship.new(ship.name, ship.length) }
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

  def first_turn(player)
    @shot_square = player.p_board.cells.keys.sample(1).join
    if player.p_board.cells[@shot_square].fired_upon? == true
      @shot_square = player.p_board.cells.keys.sample(1).join until
        player.p_board.cells[@shot_square].fired_upon? == false
    end
    player.p_board.cells[@shot_square].fire_upon
    player.p_board.cells[@shot_square].render
    @hits << @shot_square if player.p_board.cells[@shot_square].render == '⊗'.colorize(:red)
  end

  def turns(player)
    if @hits.first.nil?
      first_turn(player)
    elsif player.p_board.valid_coordinate?(((@hits.first[0].ord - 1).chr) + @hits.first[1]) && player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].fired_upon? == false
      @shot_square = (((@hits.first[0].ord - 1).chr) + @hits.first[1])
      player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].fire_upon
      player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].render
      if player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].render == '⊗'.colorize(:red)
        @hits << (((@hits.first[0].ord - 1).chr) + @hits.first[1])
      end
    elsif player.p_board.valid_coordinate?(((@hits.first[0].ord + 1).chr) + @hits.first[1]) && player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].fired_upon? == false
      @shot_square = (((@hits.first[0].ord + 1).chr) + @hits.first[1])
      player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].fire_upon
      player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].render
      if player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].render == '⊗'.colorize(:red)
        @hits << (((@hits.first[0].ord + 1).chr) + @hits.first[1])
      end
    elsif player.p_board.valid_coordinate?(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s)) && player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].fired_upon? == false
      @shot_square = (@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].fire_upon
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].render
      if player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].render == '⊗'.colorize(:red)
        @hits << (@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))
      end
    elsif player.p_board.valid_coordinate?(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s)) && player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].fired_upon? == false
      @shot_square = (@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].fire_upon
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].render
      if player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].render == '⊗'.colorize(:red)
        @hits << (@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))
      end
    else
      @hits.shift
      turns(player)
    end
  end

  def hit_check(player)

    if player.p_board.cells[@shot_square].render == '▼'.colorize(:magenta) || player.p_board.cells[@shot_square].render == '⊗'.colorize(:red)
      puts "My shot on #{shot_square} was a hit!"
    else
      puts "My shot on #{shot_square} was a miss."
    end

    puts 'I sunk a ship!' if player.p_board.cells[@shot_square].render == '▼'.colorize(:magenta)
  end
end
