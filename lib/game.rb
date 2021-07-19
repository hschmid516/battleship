
require 'io/console'
require './lib/ship'
require './lib/board'
require './lib/computer'

class Game
  attr_reader :game_mode,
              :ship_array

  def initialize
    @game_mode = game_mode
    @p_array = []
    @c_array = []
  end

  def display_board(player)
    puts "\n==============PLAYER BOARD=============="
    puts player.p_board.render(true)
    puts "\nYou now need to lay out your ships."
    # sleep 2
    # puts 'The Cruiser is three units long and the Submarine is two units long.'
  end

  def display_boards(com, player)
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    puts com.com_board.render
    puts '==============PLAYER BOARD=============='
    puts player.p_board.render(true)
  end

  def create_ships
    cs_name = ''
    cs_length = 0
    num_check = 0
    continue = 'y'
    puts "Create ship number 1"
    puts "What is the name of the ship?"
    cs_name = gets.strip.to_s
    puts "What is the length of the ship?"
    num_check = gets.strip.to_i
    require 'pry'; binding.pry
    while num_check > 0 == false
      puts "Please input an integer."
      num_check = gets.strip.to_i
    end
    cs_length = num_check
    @p_array << Ship.new(cs_name, cs_length)
    @c_array << Ship.new(cs_name, cs_length)
    puts "Would you like to make another ship? [Y]es or [N]o"
    continue = gets.strip.downcase
    i = 2
    while continue != 'n'
      if continue == 'y'
        puts "Create ship number #{i}"
        puts "What is the name of the ship?"
        cs_name = gets.strip.to_s
        puts "What is the length of the ship?"
        num_check = gets.strip.to_i
        while num_check > 0 == false
          puts "Please input an integer."
          num_check = gets.strip.to_i
        end
        cs_length = num_check
        @p_array << Ship.new(cs_name, cs_length)
        @c_array << Ship.new(cs_name, cs_length)
        i += 1
        puts "Would you like to make another ship? [Y]es or [N]o"
        continue = gets.strip.downcase
      else
        puts "Please enter y or n"
        continue = gets.strip.downcase
      end
    end
      puts "All ships have been created. Press any key to continue"
      STDIN.getch
  end

  def win_condition(player, com)
    if player.ships.all? do |ship|
        ship.sunk?
      end
      puts "\nYou lose!\n"
      puts 'Press any key to continue'
      STDIN.getch
      play
    elsif com.ships.all? do |ship|
        ship.sunk?
      end
      puts "\nYou win!\n"
      puts 'Press any key to continue'
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

  def play_turns(board_size)
    com = Computer.new(board_size)
    player = Player.new(board_size)
    if @game_mode == '4'
      player.four_by_four_ships
      com.four_by_four_ships
      com.com_placement
    elsif @game_mode == 't'
      com.com_trad_placement
    end
    com.com_speaks
    puts display_board(player)
    if @game_mode == '4'
      player.player_ships
    elsif @game_mode == 't'
      player.trad_ships
    end
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

  def get_board_size
    print "Please choose a board size:\nHeight:"
    height = gets.strip.to_i

    while height.class != Integer
      height = gets.strip.to_i
    end
    print "Please choose a board width:\nWidth:"
    width = gets.strip.to_i

    while width.class != Integer
      width = gets.strip.to_i
    end
    size = [height, width]
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
      create_ships
      play_turns(get_board_size)
    end

    if @game_mode == 'q'
      abort "You may have lost the battle, but you also lost the war!"
    end
  end
end
