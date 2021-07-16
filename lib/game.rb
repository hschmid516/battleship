require './lib/ship'
require './lib/board'
require './lib/computer'

class Game
  def initialize
  end

  def display_boards(com)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    # require 'pry'; binding.pry
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    # puts player.player_board.render
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

    if play_quit == 'p'
    puts "\nSelect game mode" +
         "\n\n [4]x4 \n [T]raditional \n [C]ustom"
    play_mode = gets.strip.downcase
    end

    while play_mode != '4' && play_mode != 't' && play_mode != 'c'
      puts "\n Please enter 4 t or c"
      play_mode = gets.strip.downcase
    end

    if play_mode == '4'
      com = Computer.new(4)
      puts display_boards(com)
      # We start the turing game from here

    end

    if play_mode == 't'
      com = Computer.new(10)
      puts display_boards(com)
      # We start the traditional game from here
    end

    if play_mode == 'c'
      # We start the custom game from here
    end
  end
end
