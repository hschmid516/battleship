require './lib/ship'
require './lib/cell'

RSpec.describe Cell do
  context 'Create cell' do
    it 'exists' do
      cell = Cell.new('B4')

      expect(cell).to be_a(Cell)
    end

    it 'can show the coordinates of the cell' do
      cell = Cell.new('B4')

      expect(cell.coordinate).to eq('B4')
    end

    it 'has no ship by default' do
      cell = Cell.new('B4')

      expect(cell.ship).to eq(nil)
    end

    it 'is empty by default' do
      cell = Cell.new('B4')

      expect(cell.empty?).to be true
    end
  end
end

RSpec.describe Cell do
  context 'Placing ship' do
    it 'can create a ship' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)

      expect(cruiser).to be_a(Ship)
    end

    it 'can place a ship' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)

      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
      expect(cell.empty?).to be false
    end
  end
end

RSpec.describe Cell do
  context 'Taking fire' do
    it 'is not fired upon by default' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to be false
    end

    it 'takes damgage when fired upon' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      cell.fire_upon

      expect(cell.ship.health).to eq(2)
    end

    it 'shows that it was fired upon' do
      cell = Cell.new('B4')
      cruiser = Ship.new('Cruiser', 3)
      cell.place_ship(cruiser)

      cell.fire_upon

      expect(cell.fired_upon?).to be true
    end
  end
end
