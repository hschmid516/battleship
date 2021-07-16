require 'io/console'

class Player
  attr_reader :ship_square,
              :p_board,
              :cruiser,
              :submarine,
              :shot_square

  def initialize
    @ship_square = []
    @p_board     = Board.new(4)
    @cruiser     = cruiser
    @submarine   = submarine
    @shot_square = nil

    def player_ships
      puts 'Enter the squares for the Cruiser (3 spaces):'
      @ship_square << gets.strip.upcase
      puts "Square 1: #{ship_square}. Enter Square 2:"
      @ship_square << gets.strip.upcase
      puts "Square 2: #{ship_square}. Enter Square 3:"
      @ship_square << gets.strip.upcase
      puts "Square 3: #{ship_square}."
      @cruiser = Ship.new(cruiser, 3)
      @p_board.valid_placement?(cruiser, @ship_square)

      while @p_board.valid_placement?(cruiser, @ship_square) == false
        @ship_square = []
        puts 'Those are invalid coordinates. Please try again:'
        puts 'Enter the squares for the Cruiser (3 spaces):'
        @ship_square << gets.strip.upcase
        puts "Square 1: #{ship_square}. Enter Square 2:"
        @ship_square << gets.strip.upcase
        puts "Square 2: #{ship_square}. Enter Square 3:"
        @ship_square << gets.strip.upcase
        puts "Square 3: #{ship_square}."
        @p_board.valid_placement?(cruiser, @ship_square)
      end

      @p_board.place(cruiser, @ship_square)
      system "clear"
      system "cls"
      puts @p_board.render(true)

      @ship_square = []
      puts 'Enter the squares for the Submarine (2 spaces):'
      @ship_square << gets.strip.upcase
      puts "Square 1: #{ship_square}. Enter Square 2:"
      @ship_square << gets.strip.upcase
      @submarine = Ship.new(submarine, 2)
      @p_board.valid_placement?(submarine, @ship_square)

      while @p_board.valid_placement?(submarine, @ship_square) == false
        @ship_square = []
        puts 'Those are invalid coordinates. Please try again:'
        puts 'Enter the squares for the Submarine (2 spaces):'
        @ship_square << gets.strip.upcase
        puts "Square 1: #{ship_square}. Enter Square 2:"
        @ship_square << gets.strip.upcase
        @p_board.valid_placement?(submarine, @ship_square)
      end

      @p_board.place(submarine, @ship_square)

      system 'clear'
      system 'cls'
      puts @p_board.render(true)
      puts 'Ships placed. Press any key to start'
      STDIN.getch
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
end
