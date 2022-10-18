# require './lib/ship'

class Cell

  attr_reader :ship, :cells

  def initialize(coord)
    @coord = coord
    @cells = {@coord => nil}
    @renders = [".", "M", "H", "X", "S"]
    @ship = nil
    @fired_upon = false
  end

  def coordinate
    @coord
  end

  def empty?
    @cells[@coord].nil?
  end

  def place_ship(ship)
    @ship = ship
    @cells[@coord] = 0
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship ? (@ship.hit; @cells[@coord] = 2) : @cells[@coord] = 1
  end

  def render(show = false)
    if fired_upon?
      if @ship.health != 0
        @ship ? (return @renders[2]) : (return @renders[1])
      else
        return @renders[3]
      end
    else
      show && @ship ? (return @renders[4]) : (return @renders[0])
    end
  end
end

class Ship
  def initialize()
    
  end

  def hit

  end
end