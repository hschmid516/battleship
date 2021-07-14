require './lib/board'
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
    it 'exists' do
      board = Board.new
      board.cells

      expect(board.validate_coordinate?("A1")).to be true
      expect(board.validate_coordinate?("D4")).to be true
      expect(board.validate_coordinate?("A5")).to be false
      expect(board.validate_coordinate?("E1")).to be false
      expect(board.validate_coordinate?("A22")).to be false
    end
  end
end
