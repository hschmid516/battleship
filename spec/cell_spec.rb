require './lib/cell.rb'

RSpec.describe Cell do
  it 'exists' do
    cell_1 = Cell.new("B4")

    expect(cell_1).to be_a(Cell)
  end
end
