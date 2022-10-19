require './lib/cell'
require 'pry'

class Board

  attr_reader :cells

  def initialize()
    @size = 16
    @cells = {}
    build_board
  end

  def build_board
    alpha = ('A'..'Z').to_a
    width = alpha[0..(Math.sqrt(@size).to_i - 1)]
    height = Math.sqrt(@size).to_i

    width.each do |letter|
      height.times do |number|
        coord = "#{letter}#{number + 1}"
        @cells[(coord)] = Cell.new(coord)
      end
    end
  end

  def valid_coordinate(coord)
    @cells.keys.include?(coord)
  end

  def valid_placement(ship, coords)
    if ship.health == coords.length
      coords.each do |coord|
        if valid_coordinate(coord) == false
          return false
        end
      end
      return true
    end
  end
end