require './lib/cell'
require 'pry'

class Board

  attr_reader :cells, :size

  def initialize()
    @size = 16
    @cells = {}
    build_board
  end

  def side
    Math.sqrt(@size).to_i
  end

  def height_chars
    ('A'..'Z').to_a[0..(side - 1)]
  end

  def width_nums
    (1..side).to_a
  end

  def build_board
    height_chars.each do |letter|
      width_nums.each do |number|
        coord = "#{letter}#{number}"
        @cells[(coord)] = Cell.new(coord)
      end
    end
    @cells = @cells.sort.to_h
  end

  def all_coordinates
    @cells.keys
  end

  def rotate_coordinates
    width_nums.map {|idx| all_coordinates.select {|coord| coord.include?(idx.to_s)}}.flatten
  end

  def valid_coordinate?(coord)
    all_coordinates.include?(coord)
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
    return false if !consecutive?(ship, coords)
    return true
  end

  def all_placements(ship)
    vert_cons = all_coordinates.each_cons(ship.length).to_a
    hor_cons = rotate_coordinates.each_cons(ship.length).to_a
    vert_cons + hor_cons
  end

  def consecutive?(ship, collection)
    all_placements(ship).include?(collection)
  end

  def place(ship, coords)
    if valid_placement?(ship, coords)
      coords.each {|coord| @cells[coord].place_ship(ship)}
    else
      :invalid
    end
  end

  def render(show = false)
    cells_render = @cells.values.map {|cell| "#{cell.render(show)} "}
    cells_lines = cells_render.each_slice(side).to_a
    first_line = width_nums.map {|number| "#{number} "}.unshift("  ").push("\n")
    remaining_lines = height_chars.map.with_index do |letter, idx| 
      "#{letter} #{cells_lines[idx].join}\n"
    end
    (first_line + remaining_lines).join
  end
end
