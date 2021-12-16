def fibs(number)
  i = 0
  j = 1
  result = []
  while result.length <= number
    result << i
    i, j = j, i + j
  end
  result
end

def fibs_rec(number)
  return 0 if number.zero?
  return 1 if number == 1

  fibs_rec(number - 1) + fibs_rec(number - 2)
end
