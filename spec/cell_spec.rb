require './lib/ship'
require './lib/cell.rb'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new("B4")

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
end
