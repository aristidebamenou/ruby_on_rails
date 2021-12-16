require_relative 'color'

# Player
class Player
  include Color

  def choose_colors
    colors = gets.chomp!.to_s.split(' ')

    while colors.length != 4 || !colors.all? { |color| COLORS.include?(color.capitalize) }
      puts 'Choose four colors between Red, Blue, Green, Yellow, Magenta, Cyan, White or Black please'
      colors = gets.chomp!.to_s.split(' ')
    end

    puts `clear`
    colors.map!(&:capitalize)
  end
end

# Represent creator of secret colors
class Creator < Player
  def create_secret_colors
    puts 'Choose your four secret colors between Red, Blue, Green, Yellow, Magenta, Cyan, White or Black please'
    choose_colors
  end
end

# Guesser of secret colors
class Guesser < Player
  def guess_secret_colors
    puts 'Red, Blue, Green, Yellow, Magenta, Cyan, White or Black'
    choose_colors
  end
end
