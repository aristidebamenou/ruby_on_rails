# frozen_string_literal: true

# Node class, containing a #value method and a link to the #next_node
class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# LinkedList class, which will represent the full list
class LinkedList
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def append(value)
    @head ? tail.next_node = Node.new(value) : @head = Node.new(value)
  end

  def prepend(value)
    node = Node.new(value)
    node.next_node = @head
    @head = node
  end

  def size
    count = 0
    each_node { count += 1 }
    count
  end

  def head
    Node.new(@head.value)
  end

  def tail
    each_node { |node| return node unless node.next_node }
  end

  def at(index)
    count = 0
    each_node do |node|
      count += 1
      return node if count == index
    end
  end

  def pop
    node = @head
    node.next_node = nil unless node.next_node.next_node while (node = node.next_node)
    node
  end

  def contains?(value)
    each_node { |node| return true if node.value == value }
    false
  end

  def find(value)
    count = 0
    each_node do |node|
      count += 1
      return count if node.value == value
    end
    nil
  end

  private

  def each_node
    return unless block_given?

    return unless @head

    node = @head
    yield node
    yield node while (node = node.next_node)
  end
end
