require './lib/board'
require './lib/cell'
require './lib/ship'

RSpec.describe Render do
  it 'places a ship' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it 'places and shows a ship' do
    board = Board.new
    cruiser = Ship.new('Cruiser', 3)
    board.place(cruiser, %w[A1 A2 A3])

    expect(board.render(true))
  end
end
