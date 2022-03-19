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

end

second_node = Node.new('data', nil)
first_node = Node.new('last', second_node)
