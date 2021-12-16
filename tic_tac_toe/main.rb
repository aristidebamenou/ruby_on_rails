require_relative 'game'

puts 'Enter the first player name: '
name = gets.chomp!
puts 'Enter the first player symbol: '
symbol = gets.chomp!

first_player = Player.new(name, symbol)

puts 'Enter the second player name: '
name = gets.chomp!
puts 'Enter the second player symbol: '
symbol = gets.chomp!

second_player = Player.new(name, symbol)

game = Game.new(first_player, second_player)

game.play
