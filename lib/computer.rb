require './lib/board'
require './lib/cell'

class Computer
  attr_reader :board_size,
              :com_board,
              :cruiser,
              :submarine,
              :shot_square,
              :destroyer,
              :battleship,
              :carrier,
              :hits

  def initialize(board_size)
    @board_size  = board_size
    @com_board   = com_board
    @cruiser     = cruiser
    @submarine   = submarine
    @shot_square = nil
    @hits        = []
  end

  def random_coords(ship, _board)
    coords = @com_board.cells.keys.sample(ship.length)

    if @com_board.valid_placement?(ship, coords) == false
      coords = @com_board.cells.keys.sample(ship.length) until
        @com_board.valid_placement?(ship, coords) == true
    end
    coords
  end

  def com_placement
    @com_board = Board.new(board_size)
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 2)
    @com_board.place(@cruiser, random_coords(@cruiser, @com_board))
    @com_board.place(@submarine, random_coords(@submarine, @com_board))
  end

  def com_trad_placement
    @com_board = Board.new(board_size)
    @destroyer = Ship.new('Destroyer', 2)
    @cruiser = Ship.new('Cruiser', 3)
    @submarine = Ship.new('Submarine', 3)
    @battleship = Ship.new('Battleship', 4)
    @carrier = Ship.new('Carrier', 5)
    # @com_board.place(@carrier, random_coords(@carrier, @com_board))
    @com_board.place(@destroyer, random_coords(@destroyer, @com_board))
    @com_board.place(@cruiser, random_coords(@cruiser, @com_board))
    @com_board.place(@submarine, random_coords(@submarine, @com_board))
    @com_board.place(@battleship, random_coords(@battleship, @com_board))
  end

  def first_turn(player)
    @shot_square = player.p_board.cells.keys.sample(1).join
    if player.p_board.cells[@shot_square].fired_upon? == true
      @shot_square = player.p_board.cells.keys.sample(1).join until
        player.p_board.cells[@shot_square].fired_upon? == false

    end
    player.p_board.cells[@shot_square].fire_upon
    player.p_board.cells[@shot_square].render
    @hits << @shot_square if player.p_board.cells[@shot_square].render == 'H'
  end

  def turns(player)
    if @hits.first.nil?
      first_turn(player)
    elsif player.p_board.valid_coordinate?(((@hits.first[0].ord - 1).chr) + @hits.first[1]) && player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].fired_upon? == false
      @shot_square = (((@hits.first[0].ord - 1).chr) + @hits.first[1])
      player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].fire_upon
      player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].render
      if player.p_board.cells[(((@hits.first[0].ord - 1).chr) + @hits.first[1])].render == 'H'
        @hits << (((@hits.first[0].ord - 1).chr) + @hits.first[1])
      end
    elsif player.p_board.valid_coordinate?(((@hits.first[0].ord + 1).chr) + @hits.first[1]) && player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].fired_upon? == false
      @shot_square = (((@hits.first[0].ord + 1).chr) + @hits.first[1])
      player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].fire_upon
      player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].render
      if player.p_board.cells[(((@hits.first[0].ord + 1).chr) + @hits.first[1])].render == 'H'
        @hits << (((@hits.first[0].ord + 1).chr) + @hits.first[1])
      end
    elsif player.p_board.valid_coordinate?(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s)) && player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].fired_upon? == false
      @shot_square = (@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].fire_upon
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].render
      if player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))].render == 'H'
        @hits << (@hits.first[0] + ((@hits.first[1].to_i - 1).to_s))
      end
    elsif player.p_board.valid_coordinate?(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s)) && player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].fired_upon? == false
      @shot_square = (@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].fire_upon
      player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].render
      if player.p_board.cells[(@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))].render == 'H'
        @hits << (@hits.first[0] + ((@hits.first[1].to_i + 1).to_s))
      end
    else
      @hits.shift
      turns(player)
    end
  end

  def hit_check(player)
    if player.p_board.cells[@shot_square].render == 'X' ||
       player.p_board.cells[@shot_square].render == 'H'
      puts "My shot on #{shot_square} was a hit!"
    else
      puts "My shot on #{shot_square} was a miss."
    end

    puts 'I sunk a ship!' if player.p_board.cells[@shot_square].render == 'X'
  end

  def com_speaks
    system 'clear'
    system 'cls'
    puts 'I have laid out my ships on the grid.'
    # sleep 2
  end
end
