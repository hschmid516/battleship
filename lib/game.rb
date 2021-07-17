
require 'io/console'
require './lib/ship'
require './lib/board'
require './lib/computer'

class Game

  def display_boards(com, player)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    puts player.p_board.render(true)
  end

  def win_condition(player, com)
    return false unless player.cruiser.sunk? == true && player.submarine.sunk?  == true || com.cruiser.sunk? == true && com.submarine.sunk? == true

    if player.cruiser.sunk? == true && player.submarine.sunk?  == true
      puts "\nYou lose!\n"
      puts 'Press any key to return to main menu.'
      STDIN.getch
      play

    elsif com.cruiser.sunk? == true && com.submarine.sunk? == true
      puts "\nYou win!\n"
      puts 'Press any key to return to main menu.'
      STDIN.getch
      play
    end
  end

  def hit_check(com, player)
    player.hit_check(com)
    com.hit_check(player)

    puts 'Press any key to continue'
    STDIN.getch
  end

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

  def play_quit
    input = gets.strip.downcase

    while input != 'p' && input != 'q'
      puts "\nPlease enter p or q"
      input = gets.strip.downcase
    end

    if input == 'q'
      abort "You may have lost the battle, but you also lost the war!"
    end

    system "clear"
    system "cls"
  end

  def play_turns(board_size)
    com = Computer.new(board_size)
    com.com_placement
    com.com_speaks
    # puts display_boards(com)

    player = Player.new(board_size)
    player.player_ships
    puts display_boards(com, player)
    player.turns(com)
    com.turns(player)
    hit_check(com, player)
    puts display_boards(com, player)

    while win_condition(player, com) == false
      player.turns(com)
      com.turns(player)
      hit_check(com, player)
      puts display_boards(com, player)
    end
  end

  def play
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

    play_quit

    puts "Select game mode" +
         "\n\n[4]x4\n[T]raditional\n[C]ustom\n[Q]uit"
    game_mode = gets.strip.downcase


    while game_mode != '4' && game_mode != 't' && game_mode !=
       'c' && game_mode != 'q'
      puts "\n Please enter 4, t, c, or q"

      game_mode = gets.strip.downcase
    end

    if game_mode == '4'
      play_turns(4)
    end

    if game_mode == 't'
      play_turns(10)
    end

    if game_mode == 'c'
      # We start the custom game from here
    end

    if game_mode == 'q'
      abort "You may have lost the battle, but you also lost the war!"
    end
  end
end
