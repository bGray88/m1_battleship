require './lib/cell'
require 'pry'

class Board

  attr_reader :cells

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

  def valid_placement?(ship, coords)
    return false if ship.health != coords.length
    coords.each do |coord|
      return false if !valid_coordinate?(coord)
      return false if !@cells[coord].empty?
    end
    if uniq_size?(coords, 0)
      return false if uniq_size?(coords, 1)
      return false if !consecutive?(coords, 1)
    elsif uniq_size?(coords, 1)
      return false if !consecutive?(coords, 0)
    else
      return false
    end
    return true
  end

  def uniq_size?(collection, idx)
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
