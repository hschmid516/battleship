require './lib/game'
require './lib/board'

RSpec.describe Game do
  context 'Setup' do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
      require 'pry'; binding.pry
    end
  end
end
