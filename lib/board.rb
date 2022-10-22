require './lib/cell'
require 'pry'

class Board

  attr_reader :cells, :side, :size, :height_chars, :width_nums

  def initialize()
    @size = 16
    @side = Math.sqrt(@size).to_i
    @height_chars = ('A'..'Z').to_a[0..(@side - 1)]
    @width_nums = (1..@side).to_a
    @cells = {}
    build_board
  end

  def build_board
    @height_chars.each do |letter|
      @width_nums.each do |number|
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
    else
      :invalid
    end
  end

  def random_cell
    @cells.values.shuffle[0]
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
      coords.each {|coord| @cells[coord].place_ship(ship)}
    else
      :invalid
    end
  end

  def render(show = false)
    @cells_render = @cells.values.map {|cell| "#{cell.render(show)} "}
    @cells_lines = @cells_render.each_slice(@side).to_a
    first_line = @width_nums.map {|number| "#{number} "}.unshift("  ").push("\n")
    remaining_lines = @height_chars.map.with_index do |letter, idx| 
      "#{letter} #{@cells_lines[idx].join}\n"
    end
    (first_line.join + remaining_lines.join)
  end
end
