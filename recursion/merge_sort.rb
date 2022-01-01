def merge_sort(array)
  return array if array.length < 2

  middle = array.length / 2
  left = merge_sort array[0...middle]
  right = merge_sort array[middle..array.length]
  sorted = []

  until left.empty? || right.empty?
    left.first <= right.first ? sorted << left.shift : sorted << right.shift
  end

  sorted + left + right
end

p merge_sort([1, 45, 56, 3, 10, 30, 40, 60, 95])
p merge_sort([1])
