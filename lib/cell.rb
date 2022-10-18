# require './lib/ship'

class Cell

  attr_reader :ship

  def initialize(value)
    @value = value
    @cells = {@value => nil}
    @renders = [".", "M", "H", "X"]
    @ship = nil
    @fired_upon = false
  end

  def coordinate
    @value
  end

  def empty?
    @cells[@value].nil?
  end

  def place_ship(ship)
    @ship = ship
    @cells[@value] = 1
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship == true ? @ship.hit : nil
  end

  def render(show = false)
    show && @ship ? "S" : "."
  end
end

class Ship
  def initialize()
    
  end
end