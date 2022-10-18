# require './lib/ship'
require './lib/cell'
require 'rspec'

describe Cell do
  describe '#initialize?' do
    it 'Creates instance of Cell' do
      cell = Cell.new("B4")

      expect(cell).to be_instance_of(Cell)
    end

    it 'Cell is empty when created' do
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq("B4")
      expect(cell.ship).to eq(nil)
      expect(cell.empty?).to be true
    end
  end

  describe '#Ship placement' do
    xit 'Accepts ship instance and places it' do
      cell = Cell.new("B4")

      expect
    end
  end

  describe '#Ship damage when fired upon' do
    xit 'Details effect of damage to ship' do
      cell = Cell.new("B4")

      expect
    end
  end
end
