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
    @head ? find_tail.next_node = Node.new(value) : @head = Node.new(value)
  end

  private

  def find_tail
    node = @head
    return node unless node.next_node

    return node unless node.next_node while (node = node.next_node)
  end
end

