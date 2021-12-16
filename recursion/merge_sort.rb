def merge_sort(array)
  if array.size == 1
    array
  else
    merge_sort(array[0..array.length / 2]) << merge_sort(array[array.length / 2..array.length])
  end
end

p merge_sort([1, 45, 56, 3])
