require './monster'
require './player'
require './spaceship'

class Game
  G = 9.81

  attr_reader :status

  def initialize
    @monster    = Monster.new
    @player     = Player.new
    @spaceship  = Spaceship.new
    @game_on    = true
    @winner     = nil
  end

  def status
    return '' if @winner.nil?
    @winner ? :win : :loose
  end

  def monster_position
    @monster.position
  end

  def player_position
    @player.position
  end

  def fire(angle_degrees)
    return false unless @game_on
    angle_radians = angle_degrees * Math::PI / 180
    x_impact = (2 * Math.cos(angle_radians) * Math.sin(angle_radians) * (Spaceship::NOZZLE_VELOCITY ** 2))/G
    if killed?(x_impact)
      @winner  = true
      @game_on = false
    end
    true
  end

  def next_turn
    return false unless @game_on
    @monster.move
    if eaten?
      @winner  = false
      @game_on = false
      true
    end
  end

  def over?
    !@game_on
  end

  private

  def eaten?
    monster_position == player_position
  end

  def killed?(x_impact)
    x_impact.between?(*kill_zone)
  end

  def kill_zone
    [(monster_position - Spaceship::KILL_ZONE), (monster_position + Spaceship::KILL_ZONE)]
  end
end
