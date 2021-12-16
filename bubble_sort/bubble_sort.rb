def bubble_sort(array)
  array.length.times do
    array[...array.length - 1].each_with_index do |_value, index|
      array[index], array[index + 1] = array[index + 1], array[index] if array[index] > array[index + 1]
    end
  end
  array

end

p bubble_sort([9, 6, 5, 3, 0, 2])
