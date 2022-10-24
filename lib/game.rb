require './lib/ship'
require './lib/cell'
require './lib/board'
require 'pry'

class Game
  attr_reader :player_board, :com_board, :player_ships, :com_ships

  def initialize()
    @player_board = Board.new
    @com_board = Board.new
    @player_ships = [
      p_cruiser = Ship.new("Cruiser", 3),
      p_submarine = Ship.new("Submarine", 2)
    ]
    @com_ships = [
      c_cruiser = Ship.new("Cruiser", 3),
      c_submarine = Ship.new("Submarine", 2)
    ]
    @player_curr_turn = {
      coord: "",
      status: ""
    }
    @com_curr_turn = {
      coord: "",
      status: ""
    }
  end

  def play
    loop do
      play_game = ""
      loop do 
        print_message(:greet)
        play_game = input(:choice)
        break if play_game == 'p' || play_game == 'q'
      end
      break if play_game == 'q'
      set_boards
      set_ships
      com_place_ships
      print_message(:add_placement)
      puts @player_board.render(true)
      place_ship(0, :cruiser_prompt)
      puts @player_board.render(true)
      place_ship(1, :sub_prompt)
      puts @player_board.render(true)
      loop do
        puts print_message(:c_header)
        puts @com_board.render
        puts print_message(:p_header)
        puts @player_board.render(true)
        print_message(:shoot_prompt)
        loop do
          @player_curr_turn[:coord] = input
          @player_curr_turn[:status] = @com_board.fire_shot(@player_curr_turn[:coord])
          if @player_curr_turn[:status] == :repeat
            print_message(:repeat_shot)
            @player_curr_turn[:coord] = input
            @player_curr_turn[:status] = @com_board.fire_shot(@player_curr_turn[:coord])
            break
          elsif @player_curr_turn[:status] == :invalid
            print_message(:invalid_shot)
          else
            break
          end
        end
        if game_end == :p_wins
          print_message(:p_won)
          puts print_message(:c_header)
          puts @com_board.render
          break
        end
        loop do
          @com_curr_turn[:coord] = com_shot
          @com_curr_turn[:status] = @player_board.fire_shot(@com_curr_turn[:coord])
          break if @com_curr_turn[:status] != :repeat
        end
        if game_end == :c_wins
          print_message(:c_won)
          puts print_message(:p_header)
          puts @player_board.render(true)
          break
        end
        print_message(:c_shot_result, @com_curr_turn.values)
        print_message(:p_shot_result, @player_curr_turn.values)
      end
    end
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

  def place_ship(idx, msg)
    print_message(msg)
    loop do
      user_coords = input
      if @player_board.place(@player_ships[idx], user_coords) != :invalid
        break
      end
      print_message(:invalid_place)
    end
  end

  def com_place_ships()
    @com_ships.each do |com_ship|
      loop do
        com_coords = @com_board.all_placements(com_ship).sample
        if @com_board.place(com_ship, com_coords) != :invalid
          break
        end
      end
    end
  end

  def com_shot
    @player_board.random_cell.coordinate
  end

  def print_message(key, results = [])
    messages = {
      greet:          "Welcome to BATTLESHIP \n" +
                      "Enter p to play. Enter q to quit \n",
      add_placement:  "I have laid out my ships on the grid. \n" +
                      "You now need to lay your two ships. \n" +
                      "The Cruiser is three units long and the Submarine is two units long. \n",
      cruiser_prompt: "Enter the squares for the Cruiser (3 spaces): \n",
      sub_prompt:     "Enter the squares for the Submarine (2 spaces):\n",
      invalid_place:  "Those are invalid coordinates. Please try again: \n",
      shoot_prompt:   "Enter the coordinates of your shot: \n",
      invalid_shot:   "That is an invalid coordinate. Please try again: \n",
      repeat_shot:    "You've fired here before. Please try again: \n",
      c_shot_result:  "My shot on #{results[0]} was a #{results[1]}. \n",
      p_shot_result:  "Your shot on #{results[0]} was a #{results[1]}. \n", 
      c_won:          "I won! \n",
      p_won:          "You won! \n",
      c_header:       "#{"=" * 13}COMPUTER BOARD#{"=" * 13} \n",
      p_header:       "#{"=" * 14}PLAYER BOARD#{"=" * 14} \n"
    }
    puts messages[key]
  end

  def game_end
    return :c_wins if @player_ships.all? {|p_ship| p_ship.sunk?}
    return :p_wins if @com_ships.all? {|c_ship| c_ship.sunk?}
  end

  def input(type = "")
    if type == :choice 
      gets.chomp.downcase
    else 
      gets.chomp.split.map {|coord| coord.capitalize} 
    end
  end 
end
