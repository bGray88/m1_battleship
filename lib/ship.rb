class Ship
  attr_reader :name, :length, :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = 3
  end

  def sunk?
    @health >= 1
    false
  end

  def hit
    @health -= 1
      if @health == 0
      @sunk == true
    end
  end
end
