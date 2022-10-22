require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class Game
  attr_reader

  def initialize()
    @player_board = nil
    @com_board = nil
    @player_ships = nil
    @com_ships = nil
  end

  def play
    start_game = get_player_choice(:greet)
    while start_game == 'p'
      print_message(:add_placement)
      set_boards
      set_ships
      com_place_ships
      puts @player_board.render(true)
      place_ship(0, :cruiser_prompt)
      puts @player_board.render(true)
      place_ship(1, :sub_prompt)
      puts @player_board.render(true)
      loop do
        puts @com_board.render
        puts @player_board.render(true)
        print_message(:shoot_prompt)
        p_curr_coord = ""
        p_curr_status = ""
        loop do
          p_curr_coord = input
          p_curr_status = @com_board.fire_shot(p_curr_coord)
          if p_curr_status == :repeat
            print_message(:invalid_shot)
            p_curr_coord = input
            p_curr_status = @com_board.fire_shot(p_curr_coord)
            break
          else
            break
          end
        end
        if game_end == :p_wins
          print_message(:p_won)
        end
        c_curr_coord = ""
        c_curr_status = ""
        loop do
          c_curr_coord = com_shot
          c_curr_status = @player_board.fire_shot(c_curr_coord)
          break if c_curr_status != :repeat
        end
        if game_end == :c_wins
          print_message(:c_won)
        end
        print_message(:c_shot_result, c_curr_coord, c_curr_status)
        print_message(:p_shot_result, p_curr_coord, p_curr_status)
      end
      start_game = get_player_choice(:greet)
    end
  end

  def place_ship(idx, msg)
    print_message(msg)
    loop do
      user_coords = input
      user_coords = user_coords.split.map {|coord| coord.capitalize}
      if @player_board.place(@player_ships[idx], user_coords) != :invalid
        break
      end
      print_message(:invalid_place)
    end
  end

  def com_place_ships()
    @com_ships.each do |com_ship|
      loop do
        board_size = @com_board.width.size
        bound = com_ship.length

        consec_pool = [@com_board.height, @com_board.width]
        repeat_pool = consec_pool.delete(consec_pool.sample)
        repeat_val = repeat_pool.sample
        
        start_range = (1..(board_size - bound + 1))
        first = start_range.to_a.sample
        last = first + bound - 1

        coords = (first..last).to_a.map do |idx|
          "#{repeat_val}#{consec_pool.flatten[idx - 1]}"
        end
        if /\d/.match?(repeat_val.to_s)
          coords = coords.map {|coord| coord.reverse}
        end
        if @com_board.place(com_ship, coords) != :invalid
          break
        end
      end
    end
  end

  def com_shot
    @player_board.random_cell.coordinate
  end

  def set_boards
    @player_board = Board.new
    @com_board = Board.new
  end

  def set_ships
    @player_ships = [
      p_cruiser = Ship.new("Cruiser", 3),
      p_submarine = Ship.new("Submarine", 2)
    ]
    @com_ships = [
      c_cruiser = Ship.new("Cruiser", 3),
      c_submarine = Ship.new("Submarine", 2)
    ]
  end

  def print_message(key, coord = "", status = "")
    messages = {
      greet: "Welcome to BATTLESHIP \n" +
      "Enter p to play. Enter q to quit \n",
      add_placement: "I have laid out my ships on the grid. \n" +
      "You now need to lay your two ships. \n" +
      "The Cruiser is three units long and the Submarine is two units long. \n",
      cruiser_prompt: "Enter the squares for the Cruiser (3 spaces): \n",
      sub_prompt: "Enter the squares for the Submarine (2 spaces):\n",
      invalid_place: "Those are invalid coordinates. Please try again: \n",
      shoot_prompt: "Enter the coordinates of your shot: \n",
      invalid_shot: "That is an invalid coordinate. Please try again: \n",
      c_shot_result: "My shot on #{coord} was a #{status}. \n",
      p_shot_result: "Your shot on #{coord} was a #{status}. \n", 
      c_won: "I won! \n",
      p_won: "You won! \n",
    }
    puts messages[key]
  end

  def get_player_choice(msg)
    print_message(msg)
    start_prompt = input.downcase
    until start_prompt == 'p' || start_prompt == 'q'
      start_prompt = input.downcase
    end
    start_prompt
  end

  def game_end
    return :c_wins if @player_ships.all? {|p_ship| p_ship.sunk?}
    return :p_wins if @com_ships.all? {|c_ship| c_ship.sunk?}
  end

  def input
    gets.chomp.capitalize
  end
end
