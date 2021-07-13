class Cell
  attr_reader :coordinate,
              :ship,
              :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship       = nil
    @fired_upon = false
  end

  def empty?
    if @ship.nil?
      true
    else
      false
    end
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship.nil? == false
      @ship.hit
    end
    @fired_upon = true
  end

  def render(show_ship = false)
    if @ship.nil? && fired_upon == true
      "M"
    elsif @ship.nil? == false && fired_upon == true
      "H"
    elsif show_ship == true
      "S"
    else
      "."
    end
  end
end
