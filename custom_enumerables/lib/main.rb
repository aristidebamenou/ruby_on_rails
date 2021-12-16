module Enumerable
  def my_each(&block)
    return unless block_given?

    for item in self
      block.call item
    end
  end

  def my_each_with_index(&block)
    return unless block_given?

    index = 0
    for item in self
      block.call item, index
      index += 1
    end
  end

  def my_select(&block)
    return unless block_given?

    selected = clone
    my_each { |item, value| selected.delete(item) unless block.call(item, value) }
    selected
  end

  def my_all?(&block)
    return unless block_given?

    my_each { |item, value| return false unless block.call(item, value) }
    true
  end

  def my_any?(&block)
    return unless block_given?

    my_each { |item, value| return true if block.call(item, value) }
    false
  end

  def my_none?(&block)
    return unless block_given?

    my_each { |item, value| return false if block.call(item, value) }
    true
  end

  def my_count(param = nil, &block)
    return length if !block_given? && param.nil?

    count = 0
    if param.nil?
      my_each { |item, value| count += 1 if block.call(item, value) }
    else
      my_each { |item, _| count += 1 if item == param }
    end
    count
  end

  def my_map(proc = nil, &block)
    to_apply = proc.nil? ? block : proc
    mapped = self.class.new
    case self
    in Array
      my_each { |item| mapped << to_apply.call(item) }
    in Hash
      my_each { |item, value| mapped[item] = to_apply.call(item, value).last }
    else
      return
    end
    mapped
  end

  def my_inject(accumulator = nil, &block)
    return unless block_given?

    accumulator = shift if accumulator.nil?
    my_each { |item| accumulator = block.call(accumulator, item) }
    accumulator
  end
end

def multiply_els(items)
  items.my_inject { |result, item| result * item }
end
