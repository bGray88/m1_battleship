require './lib/ship'
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
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to be_instance_of(Ship)
      expect(cell.empty?).to be false
    end
  end

  describe '#fired_upon' do
    it 'Details effect of damage to ship' do
      cell = Cell.new("B4")
      cruiser = Ship.new("Submarine", 2)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to be false

      cell.fire_upon

      expect(cell.ship.health).to eq(2)
      expect(cell.fired_upon?).to be true
    end
  end

  describe "#render" do
    it 'Displays current cell status via character' do
      cell_1 = Cell.new("A4")
      cell_2 = Cell.new("B4")
      cell_3 = Cell.new("C4")
      cruiser = Ship.new("Cruiser", 3)
      cell_1.place_ship(cruiser)
      cell_2.place_ship(cruiser)
      cell_3.place_ship(cruiser)

      expect(cell_1.render).to eq(".")
      expect(cell_1.render(true)).to eq("S")

      cell_1.fire_upon

      expect(cell_1.render).to eq("H")

      cell_2.fire_upon
      cell_3.fire_upon

      expect(cell_1.render).to eq("X")
      expect(cell_2.render).to eq("X")
      expect(cell_3.render).to eq("X")
    end
  end
end
