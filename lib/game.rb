
require './lib/ship'
require './lib/board'
require './lib/computer'

class Game
  def initialize
  end

  def display_boards(com = nil, player = nil)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    # require 'pry'; binding.pry
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    puts player.p_board.render(true)
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
      com.com_speaks
      # puts display_boards(com)

      player = Player.new
      player.player_ships
      puts 'Ships placed. Press any key to start'
      STDIN.getch
      puts display_boards(com, player)
      player.turns(com)
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
