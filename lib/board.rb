require './lib/cell'

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
        @cells[("#{letter}#{number + 1}")] = Cell.new("#{letter}#{number + 1}")
      end
    end
  end
end