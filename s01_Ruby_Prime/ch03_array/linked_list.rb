class LinkedList
  include Enumerable
  def initialize(head, tail = nil)
    @head, @tail = head, tail
  end
 
  def <<(item)
    LinkedList.new(item, self)
  end
 
  def inspect
    [@head, @tail].inspect
  end

  def each(&block)
    if block_given?
      block.call(@head)
      @tail.each(&block) if @tail
    else
      to_enum(:each)
    end
  end
end
