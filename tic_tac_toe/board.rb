class Board
  attr_accessor :table

  def initialize
    @table = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end

  def available?(number)
    @table.each do |line|
      return true if line.include?(number.to_i)
    end
    false
  end

  def display
    puts "| #{@table[0][0]} | #{@table[0][1]} | #{@table[0][2]} |"
    puts '_ _ _ _ _ _ _'
    puts "| #{@table[1][0]} | #{@table[1][1]} | #{@table[1][2]} |"
    puts '_ _ _ _ _ _ _'
    puts "| #{@table[2][0]} | #{@table[2][1]} | #{@table[2][2]} |"
  end

  def place_a_symbol(symbol, number)
    number = number.to_i
    @table.map! do |line|
      line.map! do |item|
        if line.include? number
          number == item ? symbol : item
        else
          item
        end
      end
    end
  end

  def win?(symbol)
    win_with_column?(symbol) ||
      win_with_line?(symbol) ||
      win_with_first_diagonal?(symbol) ||
      win_with_second_diagonal?(symbol)
  end

  def draw?
    @table.each do |line|
      line.each do |item|
        return false if (1..9).to_a.include?(item)
      end
    end
    true
  end

  private

  def win_with_column?(symbol)
    3.times do |time|
      return true if Array.new(3) { |item| @table[item][time] }.all? { |item| item == symbol }
    end
    false
  end

  def win_with_line?(symbol)
    @table.each do |line|
      return true if line.all? { |item| item == symbol }
    end
    false
  end

  def win_with_first_diagonal?(symbol)
    3.times do |time|
      return false if @table[time][time] != symbol
    end
    true
  end

  def win_with_second_diagonal?(symbol)
    3.times do |time|
      return false if @table.map(&:reverse)[time][time] != symbol
    end
    true
  end

end
