require 'io/console'

class Player
  attr_reader :p_board,
              :shot_square,
              :ships,
              :ship_squares


  def initialize(board_size)
    @p_board      = Board.new(board_size)
    @ships        = []
    @ship_squares = nil
    @shot_square  = nil
  end

  def four_by_four_ships
    @ships << Ship.new('Cruiser', 3)
    @ships << Ship.new('Submarine', 2)
  end

  def create_ships
    puts 'How many ships would you like to create?'
    num_ship = gets.strip.to_i
    i = 1
    num_ship.times do
      puts "\nCreate ship number #{i}"
      puts "What is the name of the ship?"
      cs_name = gets.strip.capitalize
      puts "What is the length of the ship?"
      cs_length = gets.strip.to_i
      while cs_length < 0
        puts "Please input an integer."
        cs_length = gets.strip.to_i
      end
      @ships << Ship.new(cs_name, cs_length)
      i += 1
    end
      puts "All ships have been created. Press any key to continue"
      STDIN.getch
  end

  def place_ships
    @ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      @ship_squares = gets.strip.upcase.split
        @p_board.valid_placement?(ship, @ship_squares)

        while @p_board.valid_placement?(ship, @ship_squares) == false
          puts "#{@ship_squares} are invalid coordinates. Please try again:"
          puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
          @ship_squares = gets.strip.upcase.split
          @p_board.valid_placement?(ship, @ship_squares)
        end
        @p_board.place(ship, @ship_squares)
    end

    system "clear"
    system "cls"
    puts @p_board.render(true)

    # @ship_squares = []
    # puts 'Enter the squares for the Submarine (2 spaces):'
    # print "Square 1: "
    # @ship_squares << gets.strip.upcase
    # print "Square 1: "
    # @ship_squares << gets.strip.upcase
    # # @submarine = Ship.new('Submarine', 2)
    # @p_board.valid_placement?(submarine, @ship_squares)
    #
    # while @p_board.valid_placement?(submarine, @ship_squares) == false
    #   puts "#{@ship_squares} are invalid coordinates. Please try again:"
    #   @ship_squares = []
    #   puts 'Enter the squares for the Submarine (2 spaces):'
    #   print "Square 1: "
    #   @ship_squares << gets.strip.upcase
    #   print "Square 1: "
    #   @ship_squares << gets.strip.upcase
    #   @p_board.valid_placement?(submarine, @ship_squares)
    # end
    #
    # @p_board.place(submarine, @ship_squares)

    system 'clear'
    system 'cls'
    puts @p_board.render(true)
    puts 'Ships placed. Press any key to start'
    STDIN.getch
  end

  # def trad_ships
  #   @ship_squares = []
  #   puts 'Enter the squares for the Destroyer (2 spaces):'
  #   print "Square 1: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 2: "
  #   @ship_squares << gets.strip.upcase
  #   @destroyer = Ship.new('Destroyer', 2)
  #   @p_board.valid_placement?(destroyer, @ship_squares)
  #
  #   while @p_board.valid_placement?(destroyer, @ship_squares) == false
  #     puts "#{@ship_squares} are invalid coordinates. Please try again:"
  #     @ship_squares = []
  #     puts 'Enter the squares for the Destroyer (2 spaces):'
  #     print "Square 1: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 2: "
  #     @ship_squares << gets.strip.upcase
  #     @p_board.valid_placement?(destroyer, @ship_squares)
  #   end
  #
  #   @p_board.place(destroyer, @ship_squares)
  #   system 'clear'
  #   system 'cls'
  #   puts @p_board.render(true)
  #
  #   @ship_squares = []
  #   puts 'Enter the squares for the Cruiser (3 spaces):'
  #   print "Square 1: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 2: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 3: "
  #   @ship_squares << gets.strip.upcase
  #   @cruiser = Ship.new('Cruiser', 3)
  #   @p_board.valid_placement?(cruiser, @ship_squares)
  #
  #   while @p_board.valid_placement?(cruiser, @ship_squares) == false
  #     puts "#{@ship_squares} are invalid coordinates. Please try again:"
  #     @ship_squares = []
  #     puts 'Enter the squares for the Cruiser (3 spaces):'
  #     print "Square 1: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 2: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 3: "
  #     @ship_squares << gets.strip.upcase
  #     @p_board.valid_placement?(cruiser, @ship_squares)
  #   end
  #
  #   @p_board.place(cruiser, @ship_squares)
  #   system "clear"
  #   system "cls"
  #   puts @p_board.render(true)
  #
  #   @ship_squares = []
  #   puts 'Enter the squares for the Submarine (3 spaces):'
  #   print "Square 1: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 2: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 3: "
  #   @ship_squares << gets.strip.upcase
  #   # @submarine = Ship.new('Submarine', 3)
  #   @p_board.valid_placement?(submarine, @ship_squares)
  #
  #   while @p_board.valid_placement?(submarine, @ship_squares) == false
  #     puts "#{@ship_squares} are invalid coordinates. Please try again:"
  #     @ship_squares = []
  #     puts 'Enter the squares for the Submarine (3 spaces):'
  #     print "Square 1: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 2: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 3: "
  #     @ship_squares << gets.strip.upcase
  #     @p_board.valid_placement?(submarine, @ship_squares)
  #   end
  #
  #   @p_board.place(submarine, @ship_squares)
  #   system 'clear'
  #   system 'cls'
  #   puts @p_board.render(true)
  #
  #   @ship_squares = []
  #   puts 'Enter the squares for the Battleship (4 spaces):'
  #   print "Square 1: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 2: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 3: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 4: "
  #   @ship_squares << gets.strip.upcase
  #   @battleship = Ship.new('Battleship', 4)
  #   @p_board.valid_placement?(battleship, @ship_squares)
  #
  #   while @p_board.valid_placement?(battleship, @ship_squares) == false
  #     puts "#{@ship_squares} are invalid coordinates. Please try again:"
  #     @ship_squares = []
  #     puts 'Enter the squares for the Battleship (4 spaces):'
  #     print "Square 1: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 2: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 3: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 4: "
  #     @ship_squares << gets.strip.upcase
  #     @p_board.valid_placement?(battleship, @ship_squares)
  #   end
  #
  #   @p_board.place(battleship, @ship_squares)
  #   system 'clear'
  #   system 'cls'
  #   puts @p_board.render(true)
  #
  #   @ship_squares = []
  #   puts 'Enter the squares for the Carrier (5 spaces):'
  #   print "Square 1: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 2: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 3: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 4: "
  #   @ship_squares << gets.strip.upcase
  #   print "Square 5: "
  #   @ship_squares << gets.strip.upcase
  #   @carrier = Ship.new('Carrier', 5)
  #   @p_board.valid_placement?(carrier, @ship_squares)
  #
  #   while @p_board.valid_placement?(carrier, @ship_squares) == false
  #     puts "#{@ship_squares} are invalid coordinates. Please try again:"
  #     @ship_squares = []
  #     puts 'Enter the squares for the Carrier (5 spaces):'
  #     print "Square 1: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 2: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 3: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 4: "
  #     @ship_squares << gets.strip.upcase
  #     print "Square 5: "
  #     @ship_squares << gets.strip.upcase
  #     @p_board.valid_placement?(carrier, @ship_squares)
  #   end
  #
  #   @p_board.place(carrier, @ship_squares)
  #   system 'clear'
  #   system 'cls'
  #   puts @p_board.render(true)
  #
  #   puts 'Ships placed. Press any key to start'
  #   STDIN.getch
  # end

  def hit_check(com)
    if com.com_board.cells[@shot_square].render == "X" ||
        com.com_board.cells[@shot_square].render == "H"
      puts "Your shot on #{@shot_square} was a hit!"
    else
      puts "Your shot on #{@shot_square} was a miss."
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
