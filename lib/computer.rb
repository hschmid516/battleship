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

  def sq_up
    ((@hits.first[0].ord - 1).chr) + @hits.first[1]
  end

  def sq_down
    ((@hits.first[0].ord + 1).chr) + @hits.first[1]
  end

  def sq_left
    @hits.first[0] + ((@hits.first[1].to_i - 1).to_s)
  end

  def sq_right
    @hits.first[0] + ((@hits.first[1].to_i + 1).to_s)
  end

  def valid?(player, coord)
    player.p_board.valid_coordinate?(coord)
  end

  def cells(player, coord)
    player.p_board.cells[coord]
  end

  def shot(player, coord)
    @shot_square = coord
    cells(player, coord).fire_upon
    cells(player, coord).render
    if cells(player, coord).render == '⊗'.colorize(:red)
      @hits << coord
    end
  end

  def turns(player)
    if @hits.first.nil?
      first_turn(player)
    elsif valid?(player, sq_up) && cells(player, sq_up).fired_upon? == false
      shot(player, sq_up)
    elsif valid?(player, sq_down) && cells(player, sq_down).fired_upon? == false
      shot(player, sq_down)
    elsif valid?(player, sq_left) && cells(player, sq_left).fired_upon? == false
      shot(player, sq_left)
    elsif valid?(player, sq_right) && cells(player, sq_right).fired_upon? == false
      shot(player, sq_right)
    else
      @hits.shift
      turns(player)
    end
  end
end
