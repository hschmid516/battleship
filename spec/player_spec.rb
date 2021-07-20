require './lib/game'
require './lib/ship'
require './lib/player'

RSpec.describe Player do
  it 'exists' do
    player = Player.new(4)

    expect(player).to be_a(Player)
  end

  it 'has a board' do
    player = Player.new(4)

    expect(player.p_board).to be_a(Board)
  end

  it 'creates ships' do
    player = Player.new(4)
    player.create_ships('trad')

    expect(player.ships[0].name).to eq('Cruiser')
    expect(player.ships[1].name).to eq('Submarine')
    expect(player.ships[2].name).to eq('Destroyer')
    expect(player.ships[3].name).to eq('Battleship')
    expect(player.ships[4].name).to eq('Carrier')
  end
end
