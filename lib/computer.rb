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
    cons_lets = []
    cons_nums = []
    ('A'..(board.size[0] + 64).chr).each_cons(ship.length) { |letter| cons_lets << letter }
    (1..(board.size[1])).each_cons(ship.length) { |number| cons_nums << number }
    cons_num_string = cons_nums.map do |nums|
      nums.map do |num|
        num.to_s
      end
    end

    same_nums = []
    (1..(board.size[1])).map do |num|
      ship.length.times { same_nums << num}
    end

    same_nums_ary = same_nums.each_slice(ship.length).to_a

    same_nums_str_ary = same_nums_ary.map do |nums|
      nums.map do |num|
        num.to_s
      end
    end

    same_lets = []
    ('A'..(board.size[0] + 64).chr).map do |let|
      ship.length.times { same_lets << let}
    end

    same_lets_ary = same_lets.each_slice(ship.length).to_a

    coords_1 = (same_lets_ary.map do |ary1|
      cons_num_string.map do |ary2|
        ary1.zip(ary2)
      end
    end).flatten(2)

    coords_1_ary = (coords_1.map { |coord| coord.join }).each_slice(ship.length).to_a

    coords_2 = (cons_lets.map do |ary1|
      same_nums_str_ary.map do |ary2|
        ary1.zip(ary2)
      end
    end).flatten(2)

    coords_2_ary = coords_2.map { |coord| coord.join }.each_slice(ship.length).to_a

    placement = (coords_1_ary + coords_2_ary).sample
    if @com_board.valid_placement?(ship, placement) == false
      placement = (coords_1_ary + coords_2_ary).sample until
        @com_board.valid_placement?(ship, placement)  == true
    end
    placement
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
    @shot_square = player.p_board.cells.keys.sample
    if player.p_board.cells[@shot_square].fired_upon? == true
      @shot_square = player.p_board.cells.keys.sample until
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
    puts "I sunk a ship!\n" if player.p_board.cells[@shot_square].render == '▼'.colorize(:magenta)
  end
end
