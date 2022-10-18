require './lib/board'
require './lib/ship'
require './lib/cell'
require 'rspec'

describe Board do
  describe '#initialize' do
    it 'Creates instance of Board' do
      board = Board.new()

      expect(board).to be_instance_of(Board)
    end
  end
end