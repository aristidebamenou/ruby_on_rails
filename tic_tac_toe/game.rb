require_relative 'player'
require_relative 'board'

class Game
  @@turn = 0
  attr_accessor :first_player, :second_player, :the_board

  def initialize(first_player, second_player, the_board = Board.new)
    @first_player = first_player
    @second_player = second_player
    @the_board = the_board
  end

  def display_board
    @the_board.display
  end

  def play
    while continue?
      player = @@turn.even? ? @first_player : @second_player
      number = 0

      while number.zero?
        puts "#{player.name}, choose an available case."
        number = gets.chomp!.to_i
        if !number.between?(1, 9)
          puts 'Enter a number between 1 and 9 depending on its availability'
          number = 0
        elsif !@the_board.available?(number)
          puts "The number #{number} isn't available"
          number = 0
        end
      end

      @the_board.place_a_symbol(player.symbol, number)
      display_board
      @@turn += 1
    end
    puts winner ? "The winner is #{winner}" : 'Draw!'
  end

  def continue?
    !@the_board.draw? &&
      !@the_board.win?(@first_player.symbol) &&
      !@the_board.win?(@second_player.symbol)
  end

  def winner
    return @first_player.name if @the_board.win?(@first_player.symbol)
    return @second_player.name if @the_board.win?(@second_player.symbol)

    nil
  end

end
