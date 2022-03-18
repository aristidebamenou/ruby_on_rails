class LinkedList
  attr_accessor :head, :tail

  def initialize(head=nil, tail=nil)
    @head = head
    @tail = tail
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end

end

second_node = Node.new('data', nil)
first_node = Node.new('last', second_node)
