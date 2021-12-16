def substrings(string, dictionary)
  string.downcase!
  result = {}

  dictionary.each do |word|
    if string.include?(word.downcase)
      result[word.downcase] ? result[word.downcase] += 1 : result[word.downcase] = 1
    end
  end

  result

end
