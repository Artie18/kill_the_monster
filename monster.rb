class Monster

  attr_reader :position

  MOVMENT_ALTERATIONS = [-1, 1]

  def initialize(position_variation = 1..100)
    @position = rand(position_variation)
  end

  def move
    @position += MOVMENT_ALTERATIONS[rand(0..1)]
  end
end
