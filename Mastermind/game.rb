require_relative 'player'

# Game
class Game
  include Color

  @@temptation = 0
  attr_accessor :creator, :guesser, :secret_colors, :guessed_colors

  def initialize
    choice = 1
    puts '1. Play against computer'
    puts '2. Play against an other human'

    loop do
      choice = gets.chomp!.to_i
      break if [1, 2].include?(choice)
    end

    @guesser = Guesser.new
    @guessed_colors = Array.new(4)

    if choice == 1
      @secret_colors = four_random_colors
    else
      @creator = Creator.new
      @secret_colors = @creator.create_secret_colors
    end
  end

  def play
    puts 'Guess the five colors'
    continue = true

    while continue && @@temptation < 12
      guessed_colors = @guesser.guess_secret_colors
      next unless guessed_colors

      @@temptation += 1
      p guessed_colors
      places, well_placed_pawns, not_well_placed_pawns = placed_pawns(@secret_colors, guessed_colors).values

      if well_placed_pawns == 4 && not_well_placed_pawns.zero?
        continue = false
      else
        puts 'Try again please'
        puts "Number of well placed pawns: #{well_placed_pawns}"
        puts "Number of not well placed pawns: #{not_well_placed_pawns}"
        p places.map { |item| item.nil? ? 'XXX' : item }
      end
    end

    puts @@temptation < 12 ? "You find it after #{@@temptation} temptation(s)" : "You lose, the secret colors was #{@the_board.secret_colors}."
  end

  def placed_pawns(secret_colors, guessed_color)
    places = Array.new(4)
    secret_colors.each_with_index do |color, index|
      places[index] = color if guessed_color[index] == secret_colors[index]
    end
    { places: places, number_of_well_placed: 4 - places.count(nil), number_of_not_well_placed: places.count(nil) }
  end
end
