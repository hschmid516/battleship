require './lib/game'
require './lib/board'
require './lib/ship'


RSpec.describe Game do
  context 'Setup' do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
    end

    xit 'can place ships randomly for com' do
      game = Game.new

      expect()
    end

    it 'returns the board when the com places ships' do
      game = Game.new
      require 'pry'; binding.pry
      expect(game.com_placement).to be_a(Board)
    end
  end
end
