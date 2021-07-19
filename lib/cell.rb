require 'colorize'

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
    @ship.nil?
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit if !@ship.nil?
    @fired_upon = true
  end

  def render(show_ship = false)
    if @ship.nil?
      if fired_upon
        '◉'.colorize(:white)
      else
        '❑'.colorize(:light_blue)
      end
    elsif ship.sunk?
      '҉'.colorize(:orange)
    elsif fired_upon
      '⊗'.colorize(:red)
    elsif show_ship == true
      '■'.colorize(:gray)
    else
      '❑'.colorize(:light_blue)
    end
  end
end
