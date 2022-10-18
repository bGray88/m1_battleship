require 'rspec'
require './lib/ship'

RSpec.describe Ship do
  describe '#initialize' do
    it 'has a name' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
    end
  end

  xit 'returns length' do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.length).to eq(3)
  end

  xit 'has health level' do
    cruiser = Ship.new("Cruiser", 3)

    expect(crusier.health).to eq(3)
  end

  xit 'has been sunk?' do
    cruiser = Ship.new("Cruiser", 3)

    expect(crusier.sunk?).to be true
  end

  xit 'has been hit' do
    cruiser = Ship.new("Cruiser", 3)

    expect(crusier.sunk?).to be true
  end

  xit 'has been sunk?' do
    cruiser = Ship.new("Cruiser", 3)
    expect(cuiser.sunk?).to be true
    cruiser.hit
    expect(cuiser.sunk?).to be true
    cruiser.hit
    expect(cuiser.sunk?).to be true
    cruiser.hit
    expect(cuiser.sunk?).to be false
  end


end
