require './lib/ship'

RSpec.describe Ship do
  it 'exists' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_a(Ship)
  end

  it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
  end

  it 'displays length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it 'displays health' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it 'is not sunk' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be false
  end
end
