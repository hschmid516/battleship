require 'io/console'
require './lib/ship'
require './lib/board'

class Player
  attr_reader :p_board,
              :shot_square,
              :ships,
              :ship_squares

  def initialize(board_size)
    @p_board      = Board.new(board_size)
    @ships        = []
    @ship_squares = nil
    @shot_square  = nil
  end

  def create_ships(mode)
    @ships << Ship.new('Cruiser', 3)
    @ships << Ship.new('Submarine', 2)
    if mode == 'trad'
      @ships << Ship.new('Destroyer', 3)
      @ships << Ship.new('Battleship', 4)
      @ships << Ship.new('Carrier', 5)
    end
  end

  def custom_ships
    puts 'How many ships would you like to create?'
    num_ship = gets.strip.to_i
    i = 1

    num_ship.times do
      puts "\nCreate ship number #{i}"
      puts "What is the name of the ship?"
      ship_name = gets.strip.capitalize
      puts "What is the length of the ship?"
      ship_length = gets.strip.to_i
      while ship_length < 1
        puts "Please input a positive integer."
        ship_length = gets.strip.to_i
      end

        @ships << Ship.new(ship_name, ship_length)
        i += 1
      end
    puts "All ships have been created. Press any key to continue"
    STDIN.getch
    @ships
  end

  def place_ships
    @ships.each do |ship|
      puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
      @ship_squares = gets.strip.upcase.split
      @p_board.valid_placement?(ship, @ship_squares)
      while @p_board.valid_placement?(ship, @ship_squares) == false
        puts "#{@ship_squares} are invalid coordinates. Please try again:"
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
        @ship_squares = gets.strip.upcase.split
        @p_board.valid_placement?(ship, @ship_squares)
      end
      @p_board.place(ship, @ship_squares)
    end
    system 'clear'
    system 'cls'
    puts @p_board.render(true)
    puts 'Ships placed. Press any key to start'
    STDIN.getch
  end

  def hit_check(com)
    if com.com_board.cells[@shot_square].render == '▼'.colorize(:magenta) || com.com_board.cells[@shot_square].render == '⊗'.colorize(:red)
      puts "Your shot on #{@shot_square} was a hit!"
    else
      puts "Your shot on #{@shot_square} was a miss."
    end

    if com.com_board.cells[@shot_square].render == '▼'.colorize(:magenta)
      puts "You sunk a ship!"
    end
  end

  def turns(com)
    puts "Enter the coordinate for your shot:"
    @shot_square = gets.strip.upcase
    while com.com_board.valid_coordinate?(@shot_square) == false
      puts "Please enter a valid coordinate:"
      @shot_square = gets.strip.upcase
    end

    while com.com_board.cells[@shot_square].fired_upon? == true
      puts "You have already fired here. Try again:"
      @shot_square = gets.strip.upcase
        while com.com_board.valid_coordinate?(@shot_square) == false
          puts "Please enter a valid coordinate:"
          @shot_square = gets.strip.upcase
        end
    end

    com.com_board.cells[@shot_square].fire_upon
    com.com_board.cells[@shot_square].render
  end
end
