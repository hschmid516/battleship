class Game
  attr_reader :player

  def initialize
    @player = Player.new
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

    com_board.place(cruiser, random_coords(cruiser, com_board))
    com_board.place(submarine, random_coords(submarine, com_board))
    com_board.render
  end

  def com_speaks
    system "clear"
    system "cls"
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts com_placement
  end

  def display_boards
    system "clear"
    system "cls"
    puts '=============COMPUTER BOARD============='
    puts com_placement
    puts '==============PLAYER BOARD=============='
    puts com_placement
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
    print_slow("Welcome to...\n")
    print_fast("
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
      com_placement
      com_speaks
      @player.player_ships

      display_boards
    end

    if play_mode == 't'
      # We start the traditional game from here
    end

    if play_mode == 'c'
      # We start the custom game from here
    end

    if play_mode == 'q'
      abort "Sorry to see you go!"
    end
  end
end
