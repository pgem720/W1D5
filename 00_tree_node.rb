class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    if self.parent != nil # this alters old parents children array
      old_parent_arr = self.parent.children 
      i = old_parent_arr.index(self)
      self.parent.children.delete_at(i)
    end


    @parent = parent
    if parent != nil  #sets new parents chldren array
      self.parent.children << self if !self.parent.children.include?(self)
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent == nil
    raise error "node is not a child"
    end
    child_node.parent = nil
  end

  def dfs(target_value)
    
    return self if self.value == target_value
    self.children.each do |child|
      search = child.dfs(target_value)
      return search unless search.nil? #to cover the leaves b/c doesnt return since the leaves aren't considered "self"
    end
    nil
  end
    
  def bfs(target_value)
    queue = [self]

    until queue.empty?
        node = queue.shift
        return node if node.value == target_value
        
        node.children.each do |child|
            queue.push(child)
        end
    end
    nil
  end  

  


end