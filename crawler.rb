class Node
  attr_accessor :value, :parent, :l_child, :r_child
  def initialize(value = nil, parent = nil, l_child = nil, r_child = nil)
    @value = value
    @parent = parent
    @l_child = l_child
    @r_child = r_child
  end
end

class BinaryTree
  attr_accessor :head
  def initialize
    @head = Node.new('the_head')
  end
=begin
  def show_children(@head)
    ary = []
    ary << parent.l_child
    ary << parent.r_child
    ary
  end
=end
  def build_tree(array)
    @head.value = array[0]
    array[1..-1].each do |a_value|
      done = false
      tmp = @head
      while done == false
        if a_value < tmp.value && tmp.l_child == nil
          tmp.l_child = Node.new(a_value, tmp)
          tmp.l_child.parent = tmp
          done = true
        elsif a_value >= tmp.value && tmp.r_child == nil
          tmp.r_child = Node.new(a_value, tmp)
          tmp.r_child.parent = tmp
          done = true
        elsif a_value < tmp.value
          tmp = tmp.l_child
        elsif a_value >= tmp.value
          tmp = tmp.r_child
        end
      end
    end
    @head
  end

  def breadth_first_search(searched_value)
    queue = [] #using queue data structure fifo
    tmp = @head

    finished = false
    while finished == false
      if tmp.value == searched_value
        finished = true
        p 'FOUND IT'
        return tmp
      end
      if tmp.l_child != nil
        queue << tmp.l_child
      end
      if tmp.r_child != nil
        queue << tmp.r_child
      end
      if queue.empty?
        finished = true
        p 'NOT FOUND'
        return nil
      end
      tmp = queue.shift
    end
  end

  def depth_first_search(searched_value)
    stack = [] #using stack data structure
    tmp = @head
    found = false
    marked = [nil]
    while found == false
      if tmp.value == searched_value
        found = true
        p 'FOUND IT'
        return tmp
      end
      if marked.include?(tmp.l_child) && marked.include?(tmp.r_child)
        marked << stack.pop
        tmp = stack[-1]
      elsif tmp.l_child != nil && !marked.include?(tmp.l_child)
        stack << tmp.l_child
        tmp = stack[-1]
      elsif tmp.r_child != nil && !marked.include?(tmp.r_child)
        stack << tmp.r_child
        tmp = stack[-1]
      end
      if stack.empty?
        found = true
        p 'NOT FOUND'
        return nil
      end
    end
  end

  def dfs_rec(search_value, marked = [nil], tmp = @head)
     p tmp if tmp.value == search_value
      if marked.include?(tmp.l_child) && marked.include?(tmp.r_child)
      else
        if tmp.l_child != nil 
          dfs_rec(search_value, marked, tmp.l_child)
        end
        if tmp.r_child != nil 
          dfs_rec(search_value, marked, tmp.r_child)
        end
    end

  end
end

b = BinaryTree.new
b.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
#p b.breadth_first_search(11)
#p b.depth_first_search(11)
p b.dfs_rec(9)
