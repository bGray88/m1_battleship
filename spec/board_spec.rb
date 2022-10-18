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

  describe '#build_board' do
    it 'Creates a board of size attribute' do
      board = Board.new
      
      expect(board.cells.size).to eq(16)
      expect(board.cells).to be_instance_of(Hash)
      expect(board.cells.keys[0]).to eq("A1")
      expect(board.cells.values[0]).to be_instance_of(Cell)
    end
  end
end