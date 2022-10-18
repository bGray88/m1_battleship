# require './lib/ship'

class Cell
  def initialize(value)
    @value = value
    @cell = {@value => nil}
    @ship = nil
  end

  def coordinate
    @value
  end

  def ship
    @ship
  end

  def empty?
    @cell[@value].nil?
  end
end
