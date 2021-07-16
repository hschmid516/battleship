require 'io/console'

class Player
  attr_reader :ship_square

  def initialize
    @ship_square = []

    def player_ships
      p_board = Board.new(4)
      puts 'Enter the squares for the Cruiser (3 spaces):'
      @ship_square << gets.strip.upcase
      puts "Square 1: #{ship_square}. Enter Square 2:"
      @ship_square << gets.strip.upcase
      puts "Square 2: #{ship_square}. Enter Square 3:"
      @ship_square << gets.strip.upcase
      puts "Square 3: #{ship_square}."
      cruiser = Ship.new(cruiser, 3)
      p_board.valid_placement?(cruiser, @ship_square)

      while p_board.valid_placement?(cruiser, @ship_square) == false
        @ship_square = []
        puts 'Those are invalid coordinates. Please try again:'
        puts 'Enter the squares for the Cruiser (3 spaces):'
        @ship_square << gets.strip.upcase
        puts "Square 1: #{ship_square}. Enter Square 2:"
        @ship_square << gets.strip.upcase
        puts "Square 2: #{ship_square}. Enter Square 3:"
        @ship_square << gets.strip.upcase
        puts "Square 3: #{ship_square}."
        p_board.valid_placement?(cruiser, @ship_square)
      end

      p_board.place(cruiser, @ship_square)
      system "clear"
      system "cls"
      puts p_board.render(true)

      @ship_square = []
      puts 'Enter the squares for the Submarine (2 spaces):'
      @ship_square << gets.strip.upcase
      puts "Square 1: #{ship_square}. Enter Square 2:"
      @ship_square << gets.strip.upcase
      submarine = Ship.new(submarine, 2)
      p_board.valid_placement?(submarine, @ship_square)

      while p_board.valid_placement?(submarine, @ship_square) == false
        @ship_square = []
        puts 'Those are invalid coordinates. Please try again:'
        puts 'Enter the squares for the Submarine (2 spaces):'
        @ship_square << gets.strip.upcase
        puts "Square 1: #{ship_square}. Enter Square 2:"
        @ship_square << gets.strip.upcase
        p_board.valid_placement?(submarine, @ship_square)
      end

      p_board.place(submarine, @ship_square)

      system 'clear'
      system 'cls'
      puts p_board.render(true)
      puts 'Ships placed. Press any key to start'
      STDIN.getch
    end
  end
end
