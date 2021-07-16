require './lib/ship'
require './lib/board'

class Game
  def initialize;

  def play
    def print_slow(text)
      text.split(//).each do |char|
        sleep 0.07
        print char
      end
    end

    def print_fast(text)
      text.split(//).each do |char|
        sleep 0.005
        print char
      end
    end

      print "                        "
      print "Welcome to...\n"
      print"
    ██████╗  █████╗ ████████╗████████╗██╗     ███████╗███████╗██╗  ██╗██╗██████╗
    ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║     ██╔════╝██╔════╝██║  ██║██║██╔══██╗
    ██████╔╝███████║   ██║      ██║   ██║     █████╗  ███████╗███████║██║██████╔╝
    ██╔══██╗██╔══██║   ██║      ██║   ██║     ██╔══╝  ╚════██║██╔══██║██║██╔═══╝
    ██████╔╝██║  ██║   ██║      ██║   ███████╗███████╗███████║██║  ██║██║██║
    ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝
    "
        puts "\n\nEnter p to play. Enter q to quit."

        play_quit = gets.strip.downcase

        while play_quit != 'p' && play_quit != 'q'
          puts "\nPlease enter p or q"
          play_quit = gets.strip.downcase
        end

        if play_quit == 'q'
          abort "Sorry to see you go!"
        end

      def random_coords(ship, board)
        coords = board.cells.keys.sample(ship.length)

        if board.valid_placement?(ship, coords) == false
          coords = board.cells.keys.sample(ship.length) until
            board.valid_placement?(ship, coords) == true
          coords
        end
      end

      def com_placement
        cruiser = Ship.new(cruiser, 3)
        submarine = Ship.new(submarine, 2)
        com_board = Board.new(4)
        # require 'pry'; binding.pry

        com_board.place(cruiser, random_coords(cruiser, com_board))
      end
    end
  end
end
play
