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

  describe '#valid_coordinate?' do
    it 'Checks if coordinate is on cell of board' do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
    end
  end

  describe '#valid_placement?' do
    it 'Checks if coordinate is acceptable for ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A5"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      # expect(board.valid_placement?(submarine, ["A2", "A5"])).to be false
      # expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
      # expect(board.valid_placement?(submarine, ["A2", "A4"])).to be false
    end
  end
end
