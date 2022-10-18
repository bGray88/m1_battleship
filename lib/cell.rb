# require './lib/ship'

class Cell

  attr_reader :ship, :status

  def initialize(coord)
    @coord = coord
    @status = nil
    @renders = [".", "M", "H", "X", "S"]
    @ship = nil
    @fired_upon = false
  end

  def coordinate
    @coord
  end

  def empty?
    @status.nil?
  end

  def place_ship(ship)
    @ship = ship
    @status = 0
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship 
      @ship.hit
      if @ship.sunk
        @status = 3
      else
        @status = 2
      end
    else
      @status = 1
    end
  end

  def render(show = false)
    if !empty?
      if fired_upon?
        @renders[@status]
      else
        if show && @ship
          @renders[4]
        else
          @renders[@status]
        end
      end
    else
      @renders[0]
    end
  end
end
