require 'io/console'

class Player
  attr_reader :ship_square,
              :p_board

  def initialize
    @ship_square = []
    @p_board = Board.new(4)

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
      puts 'Enter the squares for the Cruiser (3 spaces):'
      @ship_square << gets.strip.upcase
      puts "Square 1: #{ship_square}. Enter Square 2:"
      @ship_square << gets.strip.upcase
      puts "Square 2: #{ship_square}. Enter Square 3:"
      @ship_square << gets.strip.upcase
      puts "Square 3: #{ship_square}."
      cruiser = Ship.new(cruiser, 3)
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
      submarine = Ship.new(submarine, 2)
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
      # puts 'Ships placed. Press any key to start'
      # STDIN.getch
    end


    def turns(com)
      # This is all untested at the moment
      shot_square = nil
      puts "Enter the coordinate for your shot:"
      shot_square = gets.strip.upcase
      # require 'pry'; binding.pry
      while com.com_board.valid_coordinate?(com.com_board.cells[shot_square].coordinate) == false && shot_square.fired_upon? == false
        puts "Please enter a valid coordinate:"
        shot_square = gets.strip.upcase
        com.com_board.valid_coordinate?(com.com_board.cells[shot_square].coordinate)
        shot_square.fired_upon?
      end

      com.com_board.cells[shot_square].fired_upon
      com.com_board.cells[shot_square].render

      # Computer fires here

      if com.com_board.cells[shot_square].render == "X" || "H"
        puts "Your shot on #{shot_square} was a hit!"
      else
        puts "Your shot on #{shot_square} was a miss."
      end

      if #computer shot nailed it
        puts "My shot on (computer shot_square) was a hit!"
      else
        puts "My shot on (computer shot_square) was a miss!"
      end

      if com.com_board.cells[shot_square].render == "X"
        puts "You sunk a ship!"
      end

      if # computer shot sinks
        puts "I sunk a ship!"
      end

      player.win_condition
      puts 'Press any key to continue'
      STDIN.getch

      system 'clear'
      system 'cls'

      # Render the board

      turns(com)
    end
  end
end
