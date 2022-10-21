require './lib/ship'
require './lib/cell'
require './lib/board'

class Game
  attr_reader

  def initialize()
    @player_board = nil
    @com_board = nil
    @ships = nil
  end

  def play
    puts messages(0)
    start_prompt = input
    until start_prompt == 'p' || start_prompt == 'q'
      start_prompt = input
    end
    if start_prompt == 'p'
      while start_prompt == 'p'
        puts messages(1)
        set_boards
        set_ships
        puts @player_board.render(true)
        place_ship(0, 2)
        place_ship(1, 3)
        puts @player_board.render(true)
        start_prompt = nil
      end
    end
  end

  def place_ship(idx, msg)
    puts messages(msg)
    loop do
      user_coords = input
      user_coords = user_coords.split
      if @player_board.valid_placement?(@ships[idx], user_coords) == true
        @player_board.place(@ships[idx], user_coords)
        break
      end
      puts messages(4)
    end
  end

  def set_boards
    @player_board = Board.new
    @com_board = Board.new
  end

  def set_ships
    @ships = [
      cruiser = Ship.new("Cruiser", 3),
      submarine = Ship.new("Submarine", 2)
    ]
  end

  def messages(idx)
    messages = [
      "Welcome to BATTLESHIP \n" +
      "Enter p to play. Enter q to quit \n",
      "I have laid out my ships on the grid. \n" +
      "You now need to lay your two ships. \n" +
      "The Cruiser is three units long and the Submarine is two units long. \n",
      "Enter the squares for the Cruiser (3 spaces): \n",
      "Enter the squares for the Submarine (2 spaces):\n",
      "Those are invalid coordinates. Please try again: \n"
    ]
    messages[idx]
  end

  def game_end
    if @game_end == true
      @welcome
    end
  end

  def input
    gets.chomp
  end
end
