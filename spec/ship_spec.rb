require './lib/ship'

Rspec.describe Ship do
  it 'exists' do
    ship = Ship.new()

    expect(ship).to be_a(Ship)
  end
end
