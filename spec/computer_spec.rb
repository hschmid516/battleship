require './lib/computer'

RSpec.describe Computer do
  it 'exists' do
    com = Computer.new([4,4])

    expect(com).to be_a(Computer)
  end

  it 'gets board size from initialize' do
    com = Computer.new([4,4])

    expect(com.board_size).to eq([4,4])
  end

  it 'creates a new com board' do
    com = Computer.new([4,4])

    expect(com.com_board).to be_a(Board)
  end

  it 'has no ships by default' do
    com = Computer.new([4,4])

    expect(com.ships).to eq([])
  end

  it 'does not have a shot square by default' do
    com = Computer.new([4,4])

    expect(com.shot_square).to be nil
  end

  it 'the first turn creates a valid shot square' do
    com = Computer.new([4,4])
    player = Player.new([4,4])

    com.first_turn(player)
    expect(com.com_board.valid_coordinate?(com.shot_square)).to be true
  end

  it 'has no hits by default' do
    com = Computer.new([4,4])

    expect(com.hits).to eq([])
  end
end
