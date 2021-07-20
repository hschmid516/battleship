require './lib/game'
require './lib/board'
require './lib/ship'

RSpec.describe Game do
  context 'Setup' do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
    end

    it 'starts out without a game mode' do
      game = Game.new

      expect(game.game_mode).to be nil
    end
  end
end
