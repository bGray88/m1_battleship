require './lib/ship'

class Cell

  attr_reader :ship, :status, :coordinate

  def initialize(coord)
    @coordinate = coord
    @status = :empty
    @renders = {
      empty: ".", 
      miss: "M",
      hit: "H", 
      sunk: "X", 
      ship: "S"
    }
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @status == :empty
  end

  def place_ship(ship)
    @ship = ship
    @status = :ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !@fired_upon
      @fired_upon = true
      if @ship
        @ship.hit
        if @ship.sunk?
          @status = :sunk
        else
          @status = :hit
        end
      else
        @status = :miss
      end
    else
      :repeat
    end
  end

  def render(show = false)
    if @status == :ship && !show
      @renders[:empty]
    else
      if @ship
        @status = :sunk if @ship.sunk?
      end
      @renders[@status]  
    end
  end
end
