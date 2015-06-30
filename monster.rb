class Monster

  attr_reader :position

  MOVMENT_ALTERATIONS = [-1, 1]

  # Create a monster class
  #
  # @param [Range] position_variation is a possibility of monster positions
  # @return [Monster] self class monster
  def initialize(position_variation = 1..100)
    @position = rand(position_variation)
  end

  # Move the monster randomly
  #
  # @return [Integer] new position of the monster
  def move
    @position += MOVMENT_ALTERATIONS[rand(0..1)]
  end
end
