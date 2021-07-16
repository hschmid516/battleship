require 'io/console'

class Player
  def player_placement
  end

  def player_ships
    puts "Enter the squares for the Cruiser (3 spaces)"
    @ship_square = gets.strip.upcase
    puts "Square 1: #{ship_square}. Enter Square 2"
    @ship_square = gets.strip.upcase
    puts "Square 2: #{ship_square}. Enter Square 3"
    @ship_square = gets.strip.upcase
    puts "Square 3: #{ship_square}."
    # Verify and place
    # If not valid, redo
    # show board, render true
    puts "Enter the squares for the Submarine (2 spaces)"
    ship_square = gets.strip.upcase
    puts "Square 1: #{ship_square}. Enter Square 2"
    ship_square = gets.strip.upcase
    # Verify and place
    # If not valid, redo
    # show board, render true
    system "clear"
    system "cls"
    puts "Ships placed. Press any key to start"
    STDIN.getch
  end


  def player_turn
  end
end
