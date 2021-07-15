class Board
  attr_reader :ship,
              :cells

  def initialize
    @ship  = ship
    @cells = { 'A1' => Cell.new('A1'),
               'A2' => Cell.new('A2'),
               'A3' => Cell.new('A3'),
               'A4' => Cell.new('A4'),
               'B1' => Cell.new('B1'),
               'B2' => Cell.new('B2'),
               'B3' => Cell.new('B3'),
               'B4' => Cell.new('B4'),
               'C1' => Cell.new('C1'),
               'C2' => Cell.new('C2'),
               'C3' => Cell.new('C3'),
               'C4' => Cell.new('C4'),
               'D1' => Cell.new('D1'),
               'D2' => Cell.new('D2'),
               'D3' => Cell.new('D3'),
               'D4' => Cell.new('D4') }
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
    same_letters?(coords) && !ship_overlap?(coords)||
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
      @cells[coord].ship != nil
    end
  end
end
