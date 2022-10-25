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

  describe '#side' do
    it 'Sets side length equal to square root of total size' do
      board = Board.new()

      expect(board.side).to eq(4)
    end
  end

  describe '#height_chars' do
    it 'Sets character array elements equal to number of cells' do
      board = Board.new()

      expect(board.height_chars).to eq(["A", "B", "C", "D"])
    end
  end

  describe '#width_nums' do
    it 'Sets character array elements equal to number of cells' do
      board = Board.new()

      expect(board.width_nums).to eq([1, 2, 3, 4])
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

  describe '#random_coordinate' do
    it 'Returns random coordinate value from valid range' do
      board = Board.new


      expect(board.valid_coordinate?(board.random_coordinate)).to be true
      expect(board.valid_coordinate?(board.random_coordinate)).to be true
      expect(board.valid_coordinate?(board.random_coordinate)).to be true
    end
  end

  describe '#all_coordinates' do
    it 'All coordinates available on board in upright order' do
      board = Board.new()

      expect(board.all_coordinates.length).to eq(16)
      expect(board.all_coordinates[0..2]).to eq(["A1", "A2", "A3"])
    end
  end

  describe '#rotate_coordinates' do
    it 'All coordinates available on board in rotated order' do
      board = Board.new()

      expect(board.rotate_coordinates.length).to eq(16)
      expect(board.rotate_coordinates[0..2]).to eq(["A1", "B1", "C1"])
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

  describe '#all_placements' do
    it 'Provides all possible placement collections for ship length' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.all_placements(cruiser).length).to eq(16)
      expect(board.all_placements(cruiser)[0]).to eq(["A1", "A2", "A3"])
    end
  end

  describe '#consecutive' do
    it 'Checks board placement values for matching consecutive sets' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      coordinates_1 = ["A1", "A2", "A3"]
      coordinates_2 = ["A1", "A2", "A4"]

      expect(board.consecutive?(cruiser, coordinates_1)).to be true
      expect(board.consecutive?(cruiser, coordinates_2)).to be false
    end
  end

  describe '#place' do
    it 'Allows placement of ship' do
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
    it 'Shows proper ship placement and layout of user interface' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
      layout_no_show = "\n  1 2 3 4 \n" +
                        "A . . . . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n\n"
      layout_show = "\n  1 2 3 4 \n" +
                        "A S S S . \n" +
                        "B . . . . \n" +
                        "C . . . . \n" +
                        "D . . . . \n\n"

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.render).to eq(layout_no_show)
      expect(board.render(true)).to eq(layout_show)

      layout_no_show = "\n  1 2 3 4 \n" +
                          "A . . . . \n" +
                          "B . . . . \n" +
                          "C . . . . \n" +
                          "D . . . . \n\n"
      layout_show = "\n  1 2 3 4 \n" +
                          "A S S S . \n" +
                          "B S . . . \n" +
                          "C . . . . \n" +
                          "D . . . . \n\n"

      board.place(submarine, ["A1", "B1"])

      expect(board.render == layout_no_show).to be true
      expect(board.render == layout_show).to be false

      board.place(submarine, ["B1", "C1"])

      board.cells["A1"].fire_upon
      board.cells["A4"].fire_upon
      board.cells["B1"].fire_upon
      board.cells["C1"].fire_upon
      
      layout_no_show = "\n  1 2 3 4 \n" +
                        "A H . . M \n" +
                        "B X . . . \n" +
                        "C X . . . \n" +
                        "D . . . . \n\n"
      layout_show = "\n  1 2 3 4 \n" +
                    "A H S S M \n" +
                    "B X . . . \n" +
                    "C X . . . \n" +
                    "D . . . . \n\n"

      expect(board.render).to eq(layout_no_show)
      expect(board.render(true)).to eq(layout_show)
    end
  end

  describe '#fire_shot' do
    it 'Fires shot on specified coordinate returning status of cell' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      expect(board.fire_shot("C1")).to eq([:miss, "C1"])
      
      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.fire_shot("C1")).to eq([:repeat, "C1"])
      expect(board.fire_shot("A1")).to eq([:hit, "A1"])
      expect(board.fire_shot("B1")).to eq([:miss, "B1"])
      expect(board.fire_shot("Z1")).to eq([:invalid, "Z1"])
    end
  end
end
