require 'csv'

class Game
  @@temptation = 0

  attr_accessor :secret_word, :guessed_word, :temptation

  def initialize
    content = File.readlines('5desk.txt').map!(&:chomp!)
    choice = 1
    puts '1. Play new game'
    puts '2. Continue saved game'

    loop do
      choice = gets.chomp!.to_i
      break if [1, 2].include?(choice)
    end

    if choice == 1
      @secret_word = (content.select { |word| word.length.between? 5, 12 }).sample
      @guessed_word = (Array.new(secret_word.length) { '_' }).join
    else
      load
    end
  end

  def create_guessed_word(letter)
    array = @guessed_word.split('')
    @secret_word.split('').each_with_index do |character, index|
      if secret_word[index] == letter.upcase || secret_word[index] == letter.downcase
        array[index] = character
      end
    end
    array.join
  end

  def play
    loop do
      puts 'Guess a letter of the word'
      puts 'Enter "save" to save and quit'
      guessed_letter = gets.chomp!.to_s
      if guessed_letter == 'save'
        save
        return
      end
      @guessed_word = create_guessed_word(guessed_letter)
      @@temptation += 1
      puts @guessed_word
      break if @secret_word == @guessed_word || @@temptation > 10

      puts 'Try again'
    end
    if @@temptation <= 10
      puts "You win after #{@@temptation} temptation(s)"
    else
      puts "You lose! the secret word was \"#{@secret_word}\""
    end
  end

  def save
    headers = %w[secret_word guessed_word temptations]
    CSV.open('save_file.csv', 'w') do |file|
      file << headers
      file << [@secret_word, @guessed_word, @@temptation]
    end
  end

  def load
    content = CSV.open('save_file.csv', headers: true, header_converters: :symbol)
    content.each do |saved_game|
      @secret_word = saved_game[:secret_word]
      @guessed_word = saved_game[:guessed_word]
      @@temptation = saved_game[:temptations].to_i
    end
  end
end
