class Board
  attr_reader :ship,
              :cells

  def initialize(size)
    @ship  = ship
    @size  = size
    @cells = cell_grid = {}
             num = 1..@size
             ltr = 65.chr..(64 + @size).chr
             num.map do |num|
               ltr.map do |ltr|
                 coord = ltr + num.to_s
                 cell_grid[coord] = Cell.new(coord)
               end
             end
             cell_grid
  end

  def valid_coordinate?(coord)
    @cells.keys.to_s.include?(coord) == true
  end

  def letters_consecutive?(coords)
    letter_range = []

    letters = coords.map do |coord|
      coord[0]
    end

    ('A'..'D').each_cons(coords.length) do |letter|
      letter_range << letter
    end

    letter_range.any? do |letter|
      letter == letters
    end
  end

  def numbers_consecutive?(coords)
    num_range = []

    numbers = coords.map do |coord|
      coord[1].to_i
    end

    (1..4).each_cons(coords.length) do |num|
      num_range << num
    end

    num_range.any? do |num|
      num == numbers
    end
  end

  def same_letters?(coords)
    coords.all? do |coord|
      coord[0] == coords[0][0]
    end
  end

  def same_numbers?(coords)
    coords.all? do |coord|
      coord[1] == coords[0][1]
    end
  end

  def length_valid?(ship, coords)
    ship.length == coords.length
  end

  def valid_placement?(ship, coords)
    length_valid?(ship, coords) && numbers_consecutive?(coords) &&
      same_letters?(coords) && !ship_overlap?(coords) ||
      length_valid?(ship, coords) && letters_consecutive?(coords) &&
        same_numbers?(coords) && !ship_overlap?(coords)
  end

  def place(ship, coords)
    coords.map do |coord|
      @cells[coord].place_ship(ship)
    end
  end

  def ship_overlap?(coords)
    coords.any? do |coord|
      !@cells[coord].ship.nil?
    end
  end

  def render(show_ship = false)
    board = []
    i = 1
    board << ' '
    loop do
      board << " #{i}"
      i += 1
      break if i > @size
    end
    board << " \n"
    j = 0
    loop do
      board << "#{(65 + j).chr} "
      k = 1
      loop do
        board << "#{@cells[(65 + j).chr + k.to_s].render(show_ship)} "
        k += 1
        break if k > @size
      end
      board << "\n"
      j += 1
      break if j >= @size
    end
    board.join
  end
end
