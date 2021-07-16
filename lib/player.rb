require 'io/console'

class Player
  attr_reader :ship_square

  def initialize
    @ship_square = []

    # This is just a framework to be worked on later. Run it at the end of every turn
    # def win_condition
    #   if player.cruiser.sunk? == true && player.submarine.sunk? == true
    #     abort "You lose!"
    #   end
    #
    #   if computer.cruiser.sunk? == true && computer.submarine.sunk == true
    #     abort "You win!"
    #   end
    # end

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

    def p_board
      p_board.render(true)
    end

    def turns
      # This is all untested at the moment
      shot_square = nil
      puts "Enter the coordinate for your shot:"
      shot_square = gets.strip.upcase
      while com_board(shot_square).valid_coordinate? == false && shot_square.fired_upon? == false
        puts "Please enter a valid coordinate:"
        shot_square = gets.strip.upcase
        com_board(shot_square).valid_coordinate?
        shot_square.fired_upon?
      end

      shot_square.fired_upon
      shot_square.render

      # Computer fires here

      if shot_square.render # Is X or H
        puts "Your shot on #{shot_square} was a hit!"
      else
        puts "Your shot on #{shot_square} was a miss."
      end

      if #computer shot nailed it
        puts "My shot on (computer shot_square) was a hit!"
      else
        puts "My shot on (computer shot_square) was a miss!"
      end

      if # player shot sinks
        puts "You sunk a ship!"
      end

      if # computer shot sinks
        puts "I sunk a ship!"
      end

      # Render the board
      player.win_condition
      # restart turn
    end
  end
end
