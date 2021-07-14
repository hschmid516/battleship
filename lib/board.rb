require './lib/ship'
require './lib/cell'

class Board
  attr_reader :size

  def initialize
    @size = 4

  end

  def cells
    cell_grid = {}
    num = 1..size
    ltr = 65.chr..(64 + size).chr
    num.map do |num|
      ltr.map do |ltr|
        coord = ltr + num.to_s
        cell_grid[coord] = Cell.new(coord)
      end
    end
    cell_grid
  end

  def valid_coordinate?(coord)
    @cells.keys.include?(coord) == true
  end

  def valid_placement?(ship, coords); end
end
