
require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
  context 'Creating the board' do
    it 'exists' do
      board = Board.new

      expect(board).to be_a(Board)
    end

    it 'creates a board' do
      board = Board.new

      expect(board.cells).to be_a(Hash)
      expect(board.cells.keys.length).to eq(16)
      expect(board.cells.values.length).to eq(16)
      expect(board.cells.values.first).to be_a(Cell)
    end
  end

  context 'Creating the board' do
    it 'can validate coordinates' do
      board = Board.new
      board.cells

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end

    it 'confirms coordinates = ship length' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
      # expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
    end

    it 'confirms coordinates are consecutive'do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end
    end
  
  context 'Placing ships' do
    it 'shows a ship is placed on multiple cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])
      cell_1 = board.cells["A1"]
      cell_2 = board.cells["A2"]
      cell_3 = board.cells["A3"]

      expect(cell_1.ship).to eq(cruiser)
      expect(cell_2.ship).to eq(cruiser)
      expect(cell_3.ship).to eq(cruiser)
      expect(cell_3.ship == cell_2.ship).to be true
    end

    it 'verifies ships are not overlapping' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end
  end

  context 'Rendering the board' do
    it 'renders' do
      board = Board.new
      require 'pry'; binding.pry
      # cruiser = Ship.new('Cruiser', 3)
      # board.place(cruiser, %w[A1 A2 A3])

      expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    xit 'renders and shows a ship' do
      board = Board.new
      cruiser = Ship.new('Cruiser', 3)
      board.place(cruiser, %w[A1 A2 A3])

      expect(board.render(true))
    end
  end
end
