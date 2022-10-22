require './lib/cell'
require 'pry'

class Board

  attr_reader :cells, :height, :width, :size

  def initialize()
    @size = 16
    @alpha = ('A'..'Z').to_a
    @height = @alpha[0..(Math.sqrt(@size).to_i - 1)]
    @width = (1..(Math.sqrt(@size).to_i)).to_a
    @cells = {}
    build_board
  end

  def build_board
    @height.each do |letter|
      @width.each do |number|
        coord = "#{letter}#{number}"
        @cells[(coord)] = Cell.new(coord)
      end
    end
    @cells = @cells.sort.to_h
  end

  def valid_coordinate?(coord)
    @cells.keys.include?(coord)
  end

  def fire_shot(coord)
    if valid_coordinate?(coord)
      @cells[coord].fire_upon
    end
  end

  def random_cell
    @cells.values.shuffle[0]
  end

  def get_fire_result(coord)
    @cells[coord].status
  end

  def valid_placement?(ship, coords)
    return false if ship.health != coords.length
    coords.each do |coord|
      return false if !valid_coordinate?(coord) || !@cells[coord].empty?
    end
    if repeat_char?(coords, 0)
      return false if repeat_char?(coords, 1) || !consecutive?(coords, 1)
    elsif repeat_char?(coords, 1)
      return false if !consecutive?(coords, 0)
    else
      return false
    end
    return true
  end

  def repeat_char?(collection, idx)
    collection.map {|element| element[idx]}.uniq.size == 1
  end

  def consecutive?(collection, idx)
    user_arr = collection.map {|element| element[idx].ord}
    proper_arr = (collection.first[idx].ord..collection.last[idx].ord).to_a
    user_arr == proper_arr
  end

  def place(ship, coords)
    if valid_placement?(ship, coords)
      coords.each do |coord|
        @cells[coord].place_ship(ship)
      end
    else
      :invalid
    end
  end

  def render(show = false)
    @cells_render = @cells.values.map do |cell|
      "#{cell.render(show)} "
    end
    @cells_lines = @cells_render.each_slice(4).to_a
    first_line = @width.map do |number|
      "#{number} "
    end.unshift("  ").push("\n").join
    remaining_lines = @height.map.with_index do |letter, idx|
      "#{letter} #{@cells_lines[idx].join}\n"
    end.join
    (first_line + remaining_lines)
  end
end
