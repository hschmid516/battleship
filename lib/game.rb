
require 'io/console'
require './lib/ship'
require './lib/board'
require './lib/computer'

class Game
  attr_reader :game_mode

  def initialize
    @game_mode = game_mode
  end

  def display_board(player)
    puts "\n==============PLAYER BOARD=============="
    puts player.p_board.render(true)
    puts "\nYou now need to lay out your ships."
    # sleep 2
  end

  def display_boards(com, player)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    puts player.p_board.render(true)
  end

  def win_condition(player, com)
    if player.ships.all? { |ship| ship.sunk? } && com.ships.all? { |ship| ship.sunk? }
        puts puts "\nYou...tied?!"
        puts "\nPress any key to return to main menu."
        STDIN.getc
    elsif player.ships.all? { |ship| ship.sunk? }
      puts "\nYou lose!"
      puts "\nPress any key to return to main menu."
      STDIN.getch
      play
    elsif com.ships.all? { |ship| ship.sunk? }
      puts "\nYou win!"
      puts "\nPress any key to return to main menu."
      STDIN.getch
      play
    else
      false
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

  def turns(player, com)
    player.turns(com)
    com.turns(player)
    hit_check(com, player)
    puts display_boards(com, player)
  end

  def place_ships(com, player)
    com.com_placement
    puts display_board(player)
    player.place_ships
    puts display_boards(com, player)
    turns(player, com)
  end

  def play_turns(board_size)
    com = Computer.new(board_size)
    player = Player.new(board_size)

    if @game_mode == '4'
      player.create_ships("4x4")
      com.create_ships("4x4")
    elsif @game_mode == 't'
      player.create_ships('trad')
      com.create_ships('trad')
    elsif @game_mode == 'c'
      player.custom_ships
      com.get_ships(player.ships)
    end

    place_ships(com, player)

    while win_condition(player, com) == false
      turns(player, com)
    end
  end

  def get_board_size
    print "Please choose a board size:\nHeight: "
    height = gets.strip.to_i

    while height < 0
      height = gets.strip.to_i
    end
    print "Please choose a board width:\nWidth: "
    width = gets.strip.to_i

    while width < 0
      width = gets.strip.to_i
    end
    size = [height, width]
  end

  def play
    system "clear"
    system "cls"
    print_slow("                        Welcome to...\n")
    print_fast("
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
    @game_mode = gets.strip.downcase


    while @game_mode != '4' && @game_mode != 't' && @game_mode !=
       'c' && @game_mode != 'q'
      puts "\n Please enter 4, t, c, or q"

      @game_mode = gets.strip.downcase
    end

    if @game_mode == '4'
      play_turns([4,4])
    end

    if @game_mode == 't'
      play_turns([10,10])
    end

    if @game_mode == 'c'
      size = get_board_size
      play_turns(size)
    end

    if @game_mode == 'q'
      abort "You may have lost the battle, but you also lost the war!"
    end
  end
end
