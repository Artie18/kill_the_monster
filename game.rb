require './monster'
require './player'
require './spaceship'

class Game
  G = 9.81

  attr_reader :status

  # Initialize Game Class. And create all instance variables
  #
  # @return [Game] Game class
  def initialize
    @monster    = Monster.new
    @player     = Player.new
    @spaceship  = Spaceship.new
    @game_on    = true
    @winner     = nil
  end

  # Determens status of the finished game for the player
  #
  # @return [String] telling if player won or lost
  def status
    return '' if @winner.nil?
    @winner ? :win : :loose
  end

  # Fetches current monster position and returns it
  #
  # @return [Integer] current monster position
  def monster_position
    @monster.position
  end

  # Fetches current player position and returns it
  #
  # @return [Integer] current player position
  def player_position
    @player.position
  end

  # Implement spaceship firing logic
  #
  # @param [Float] angle_degrees angle on which the ship has fired in degrees
  # @return [Boolean] tells if operation was completed or not
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

  # Passes the turn to the computer and implements it
  #
  # @return [Boolean] tells if operation was completed or not
  def next_turn
    return false unless @game_on
    @monster.move
    if eaten?
      @winner  = false
      @game_on = false
      true
    end
  end

  # Tells if game is over or player can still play
  #
  # @return [Boolean] true - game is over, false - otherwise
  def over?
    !@game_on
  end

  private

  # Tells if player was eaten by mosnter
  #
  # @return [Boolean] true - eaten, false - otherwise
  def eaten?
    monster_position == player_position
  end

  # Tells if player killed the monster
  #
  # @param [Float] x_impact position along x where ball hits the ground
  # @return [Boolean] true - monster was killed, false - otherwise
  def killed?(x_impact)
    x_impact.between?(*kill_zone)
  end

  # Returns kill zone of a spaceship ball relatively monster
  #
  # @return [Array(Integer, Integer)] consists of beginning and the end of the kill zone
  def kill_zone
    [(monster_position - Spaceship::KILL_ZONE), (monster_position + Spaceship::KILL_ZONE)]
  end
end
