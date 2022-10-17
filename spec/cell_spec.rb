require './lib/cell'
require 'rspec'

describe Cell do
  describe '#initialize?' do
    it 'Creates instance of Cell' do
      cell = Cell.new()

      expect(cell).to be_instance_of(Cell)
    end
  end
end