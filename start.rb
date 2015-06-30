require './game'

game = Game.new

p 'Welcom to Hit The Monster '
p 'You are at 0 position'

loop do
  p "Your monster is in the #{game.monster_position}"
  p 'Enter angle (in degrees): '
  begin
    angle = Float(gets.chomp)
    game.fire(angle)
    game.next_turn
  rescue
    p 'Angel must be integer!'
  end
  break if game.over?
end


p "Game over! You #{game.status}"
