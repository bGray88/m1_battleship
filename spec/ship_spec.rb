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
end
