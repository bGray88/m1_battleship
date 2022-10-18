# require './lib/ship'
require './lib/cell'
require 'rspec'

describe Cell do
  describe '#initialize' do
    it 'Creates instance of Cell' do
      cell = Cell.new("B4")

      expect(cell).to be_instance_of(Cell)
      expect(cell.coordinate).to eq("B4")
    end

    it 'Cell is empty when created' do
      cell = Cell.new("B4")

      expect(cell.ship).to eq(nil)
      expect(cell.empty?).to be true
    end
  end

  describe '#ship' do
    it 'Accepts ship instance and places it' do
      cell = Cell.new("B4")
      cruiser = Ship.new()
      cell.place_ship(cruiser)

      expect(cell.ship).to be_instance_of(Ship)
      expect(cell.empty?).to be false
    end
  end

  describe '#fired_upon' do
    it 'Details effect of damage to ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new()
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to be false

      cell.fire_upon

      # expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be true
    end
  end

  describe "#render" do
    it 'Displays current cell status via character' do
      cell = Cell.new("B4")

      expect(cell.render).to eq(".")

      cruiser = Ship.new()
      cell.place_ship(cruiser)
      
      expect(cell.render).to eq(".")
      expect(cell.render(true)).to eq("S")
    end
  end
end
