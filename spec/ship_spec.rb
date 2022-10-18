require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  describe '#initialize' do
    it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
    end
  end

  it 'returns length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  it 'has health level' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it 'has been sunk' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be false
  end

  it 'has been hit' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be false
  end
end
