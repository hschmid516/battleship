
require 'io/console'
require './lib/ship'
require './lib/board'
require './lib/computer'

class Game
  def initialize
  end

  def display_boards(com, player)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    # require 'pry'; binding.pry
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    puts player.p_board.render(true)
  end

  def win_condition(player, com)
    if player.cruiser.sunk? == true && player.submarine.sunk? == true
      system 'clear'
      system 'cls'
      abort "You lose!"
    end

    if com.cruiser.sunk? == true && com.submarine.sunk == true
      system 'clear'
      system 'cls'
      abort "You win!"
    end
  end

  def hit_check
    if @com_board.cells[shot_square].render == "X" || "H"
      puts "Your shot on #{shot_square} was a hit!"
    else
      puts "Your shot on #{shot_square} was a miss."
    end

    if #computer shot .render == "X" || "H"
      puts "My shot on (computer shot_square) was a hit!"
    else
      puts "My shot on (computer shot_square) was a miss!"
    end

    if @com_board.cells[shot_square].render == "X"
      puts "You sunk a ship!"
    end

    if # computer shot .render == "X"
      puts "I sunk a ship!"
    end
  end

  def win_check
    player.win_condition
    puts 'Press any key to continue'
    STDIN.getch

    # Render the board

    turns(com)
  end

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

    system "clear"
    system "cls"
    print "                        "
    print("Welcome to...\n")
    print("
    ██████╗  █████╗ ████████╗████████╗██╗     ███████╗███████╗██╗  ██╗██╗██████╗
    ██╔══██╗██╔══██╗╚══██╔══╝╚══██╔══╝██║     ██╔════╝██╔════╝██║  ██║██║██╔══██╗
    ██████╔╝███████║   ██║      ██║   ██║     █████╗  ███████╗███████║██║██████╔╝
    ██╔══██╗██╔══██║   ██║      ██║   ██║     ██╔══╝  ╚════██║██╔══██║██║██╔═══╝
    ██████╔╝██║  ██║   ██║      ██║   ███████╗███████╗███████║██║  ██║██║██║
    ╚═════╝ ╚═╝  ╚═╝   ╚═╝      ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝╚═╝
    ")
    puts "\n\n                        Enter p to play. Enter q to quit."

    play_quit = gets.strip.downcase

    while play_quit != 'p' && play_quit != 'q'
      puts "\nPlease enter p or q"
      play_quit = gets.strip.downcase
    end

    if play_quit == 'q'
      abort "Sorry to see you go!"
    end

    if play_quit == 'p'

    system "clear"
    system "cls"
    puts "Select game mode" +
         "\n\n[4]x4\n[T]raditional\n[C]ustom\n[Q]uit"
    play_mode = gets.strip.downcase
    end

    while play_mode != '4' && play_mode != 't' && play_mode != 'c' && play_mode != 'q'
      puts "\n Please enter 4, t, c, or q"

      play_mode = gets.strip.downcase
    end

    if play_mode == '4'

      com = Computer.new(4)
      @com.com_speaks
      # puts display_boards(com)

      @player = Player.new
      player.player_ships
      puts 'Ships placed. Press any key to start'
      STDIN.getch
      com.com_placement
      puts display_boards(com, player)

      while player.win
      player.turns(com)
      com.turns(player)
    end

    if play_mode == 't'
      com = Computer.new(10)
      puts display_boards(com)
    end

    if play_mode == 'c'
      # We start the custom game from here
    end

    if play_mode == 'q'
      abort "You may have lost the battle, but you also lost the war!"
    end
  end
end
