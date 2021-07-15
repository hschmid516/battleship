class Board
  def initialize; end

  def cells
    cell_grid = {}
    size = 4
    num = 1..size
    ltr = 65.chr..(64 + size).chr
    num.map do |num|
      ltr.map do |ltr|
        coord = ltr + num.to_s
        cell_grid[coord] = Cell.new(coord)
      end
    end
    cell_grid
  end

  def valid_coordinate?(coord)
    cells.keys.to_s.include?(coord) == true
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
    length_valid?(ship, coords) && numbers_consecutive?(coords) && same_letters?(coords) ||
    length_valid?(ship, coords) && letters_consecutive?(coords) && same_numbers?(coords)
  end

  def render
    i = 1
    size = 4
    print " "
    loop do
      print " #{i}"
      i += 1
      if i > size
        break
      end
    end
  end
end
