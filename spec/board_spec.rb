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
    it 'Checks if coordinate is acceptable length for ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
      expect(board.valid_placement?(submarine, ["A1", "A2", "A3"])).to be false
    end

    it 'Checks if coordinate is consecutive for board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A5"])).to be false
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A3"])).to be true
      expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
      expect(board.valid_placement?(submarine, ["A2", "A4"])).to be false
    end

    it 'Checks if coordinate is diagonal for board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
    end
  end

  describe '#place' do
    it 'Confirms placement of ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.cells["A1"].render).to eq(".")

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.cells["A1"].render(true)).to eq("S")
      expect(board.cells["A2"].render(true)).to eq("S")
      expect(board.cells["A3"].render(true)).to eq("S")
    end
  end

  describe '#render' do
    it 'Confirms proper layout of user interface' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      layout_no_show = "  1 2 3 4 \n" +
                        "A . . . . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"
      layout_show = "  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n"

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render).to eq(layout_no_show)
      expect(board.render(true)).to eq(layout_show)

      board.place(submarine, ["A1", "B1"])

      expect(board.render).to eq(layout_no_show)
      expect(board.render(true)).to eq(layout_show)

      board.place(submarine, ["B1", "C1"])

      board.cells["A1"].fire_upon
      board.cells["A4"].fire_upon
      board.cells["B1"].fire_upon
      board.cells["C1"].fire_upon
      
      layout_no_show = "  1 2 3 4 \n" +
                        "A H . . M \n" +
                        "B X . . . \n" +
                        "C X . . . \n" +
                        "D . . . . \n"
      layout_show = "  1 2 3 4 \n" +
                    "A H S S M \n" +
                    "B X . . . \n" +
                    "C X . . . \n" +
                    "D . . . . \n"

      expect(board.render).to eq(layout_no_show)
      expect(board.render(true)).to eq(layout_show)
    end
  end
end
