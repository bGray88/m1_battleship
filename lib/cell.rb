require './lib/ship'

class Cell

  attr_reader :ship, :status, :coordinate

  def initialize(coord)
    @coordinate = coord
    @status = 0
    @renders = [".", "M", "H", "X", "S"]
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @status == 0
  end

  def place_ship(ship)
    @ship = ship
    @status = 4
  end

  def fired_upon? 
    @fired_upon
  end

  def fire_upon
    if !@fired_upon
      @fired_upon = true
      if @ship 
        @ship.hit
        @status = 2
      else
        @status = 1
      end
    end
  end

  def render(show = false)
    if @status == 4 && !show
      @renders[0]
    else
      @status = 3 if @ship.sunk?
      @renders[@status]
    end
  end
end
