def stock_picker(stock_prices)
  result = Array.new(2, 0)
  profit = 0

  stock_prices.each_with_index do |value, index|
    stock_prices[index..].each do |remaining_value|
      next unless remaining_value - value > profit

      profit = remaining_value - value
      result[0] = index
      result[1] = stock_prices.index(remaining_value)
    end
  end

  result

end
