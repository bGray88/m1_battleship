# require './lib/ship'

class Cell

  attr_reader :ship, :status

  def initialize(coord)
    @coord = coord
    @status = {@coord => nil}
    @renders = [".", "M", "H", "X", "S"]
    @ship = nil
    @fired_upon = false
  end

  def coordinate
    @coord
  end

  def empty?
    @status[@coord].nil?
  end

  def place_ship(ship)
    @ship = ship
    @status[@coord] = 0
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship 
      @ship.hit
        if @ship.health > 0
          @status[@coord] = 2
        else
          @status[@coord] = 3
        end
    else
      @status[@coord] = 1
    end
  end

  def render(show = false)
    if !empty?
      if fired_upon?
        @renders[@status[@coord]]
      else
        if show && @ship
          @renders[4]
        else
          @renders[@status[@coord]]
        end
      end
    else
      @renders[0]
    end
  end
end

class Ship

attr_reader :health

  def initialize()
    @health = 3
  end

  def hit
    @health -= 1
  end
end