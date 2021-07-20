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

    xit 'displays both boards for turns method' do
      game = Game.new
      game.play_turns([4, 4])

      expect(game.turns(player, com)).to eq(puts display_boards(com, player))
    end

    # it 'returns the board when the com places ships' do
    #   game = Game.new
    #   com = Computer.new([4, 4])
    #   # require 'pry'; binding.pry
    #   expect(com.com_board).to be_a(Board)
    # end
  end
end
