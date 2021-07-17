require 'io/console'

class Player
  attr_reader :p_board,
              :cruiser,
              :submarine,
              :shot_square,
              :destroyer,
              :battleship,
              :carrier

  def initialize(board_size)
    @p_board     = Board.new(board_size)
    @cruiser     = cruiser
    @submarine   = submarine
    @destroyer   = destroyer
    @battleship  = battleship
    @carrier     = carrier
    @shot_square = nil
  end

  def player_ships
    ship_square = []
    puts 'Enter the squares for the Cruiser (3 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    print "Square 3: "
    ship_square << gets.strip.upcase
    @cruiser = Ship.new('Cruiser', 3)
    @p_board.valid_placement?(cruiser, ship_square)

    while @p_board.valid_placement?(cruiser, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Cruiser (3 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      print "Square 3: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(cruiser, ship_square)
    end

    @p_board.place(cruiser, ship_square)
    system "clear"
    system "cls"
    puts @p_board.render(true)

    ship_square = []
    puts 'Enter the squares for the Submarine (2 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 1: "
    ship_square << gets.strip.upcase
    @submarine = Ship.new('Submarine', 2)
    @p_board.valid_placement?(submarine, ship_square)

    while @p_board.valid_placement?(submarine, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Submarine (2 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 1: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(submarine, ship_square)
    end

    @p_board.place(submarine, ship_square)

    system 'clear'
    system 'cls'
    puts @p_board.render(true)
    puts 'Ships placed. Press any key to start'
    STDIN.getch
  end

  def trad_ships
    ship_square = []
    puts 'Enter the squares for the Destroyer (2 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    @destroyer = Ship.new('Destroyer', 2)
    @p_board.valid_placement?(destroyer, ship_square)

    while @p_board.valid_placement?(destroyer, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Destroyer (2 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(destroyer, ship_square)
    end

    @p_board.place(destroyer, ship_square)
    system 'clear'
    system 'cls'
    puts @p_board.render(true)

    ship_square = []
    puts 'Enter the squares for the Cruiser (3 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    print "Square 3: "
    ship_square << gets.strip.upcase
    @cruiser = Ship.new('Cruiser', 3)
    @p_board.valid_placement?(cruiser, ship_square)

    while @p_board.valid_placement?(cruiser, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Cruiser (3 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      print "Square 3: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(cruiser, ship_square)
    end

    @p_board.place(cruiser, ship_square)
    system "clear"
    system "cls"
    puts @p_board.render(true)

    ship_square = []
    puts 'Enter the squares for the Submarine (3 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    print "Square 3: "
    ship_square << gets.strip.upcase
    @submarine = Ship.new('Submarine', 3)
    @p_board.valid_placement?(submarine, ship_square)

    while @p_board.valid_placement?(submarine, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Submarine (3 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      print "Square 3: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(submarine, ship_square)
    end

    @p_board.place(submarine, ship_square)
    system 'clear'
    system 'cls'
    puts @p_board.render(true)

    ship_square = []
    puts 'Enter the squares for the Battleship (4 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    print "Square 3: "
    ship_square << gets.strip.upcase
    print "Square 4: "
    ship_square << gets.strip.upcase
    @battleship = Ship.new('Battleship', 4)
    @p_board.valid_placement?(battleship, ship_square)

    while @p_board.valid_placement?(battleship, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Battleship (4 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      print "Square 3: "
      ship_square << gets.strip.upcase
      print "Square 4: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(battleship, ship_square)
    end

    @p_board.place(battleship, ship_square)
    system 'clear'
    system 'cls'
    puts @p_board.render(true)

    ship_square = []
    puts 'Enter the squares for the Carrier (5 spaces):'
    print "Square 1: "
    ship_square << gets.strip.upcase
    print "Square 2: "
    ship_square << gets.strip.upcase
    print "Square 3: "
    ship_square << gets.strip.upcase
    print "Square 4: "
    ship_square << gets.strip.upcase
    print "Square 5: "
    ship_square << gets.strip.upcase
    @carrier = Ship.new('Carrier', 5)
    @p_board.valid_placement?(carrier, ship_square)

    while @p_board.valid_placement?(carrier, ship_square) == false
      puts "#{ship_square} are invalid coordinates. Please try again:"
      ship_square = []
      puts 'Enter the squares for the Carrier (5 spaces):'
      print "Square 1: "
      ship_square << gets.strip.upcase
      print "Square 2: "
      ship_square << gets.strip.upcase
      print "Square 3: "
      ship_square << gets.strip.upcase
      print "Square 4: "
      ship_square << gets.strip.upcase
      print "Square 5: "
      ship_square << gets.strip.upcase
      @p_board.valid_placement?(carrier, ship_square)
    end

    @p_board.place(carrier, ship_square)
    system 'clear'
    system 'cls'
    puts @p_board.render(true)

    puts 'Ships placed. Press any key to start'
    STDIN.getch
  end

  def hit_check(com)
    if com.com_board.cells[@shot_square].render == "X" ||
        com.com_board.cells[@shot_square].render == "H"
      puts "Your shot on #{shot_square} was a hit!"
    else
      puts "Your shot on #{shot_square} was a miss."
    end

    if com.com_board.cells[@shot_square].render == "X"
      puts "You sunk a ship!"
    end
  end

  def turns(com)
    puts "Enter the coordinate for your shot:"
    @shot_square = gets.strip.upcase
    while com.com_board.valid_coordinate?(@shot_square) == false
      puts "Please enter a valid coordinate:"
      @shot_square = gets.strip.upcase
      com.com_board.valid_coordinate?(@shot_square)
    end

    while com.com_board.cells[@shot_square].fired_upon? == true
      puts "You have already fired here. Try again:"
      @shot_square = gets.strip.upcase
    end

    com.com_board.cells[@shot_square].fire_upon
    com.com_board.cells[@shot_square].render
  end
end
