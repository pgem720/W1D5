require_relative "00_tree_node"

require 'byebug'

class KnightPathFinder
  attr_reader :considered_positions

  def self.valid_moves(pos)
    array = [1,2,-1,-2]
    valid = []
    x,y = pos

    array.each do |i|
      array.each do |i2|
        valid << [i+x,i2+y] if i + i2 != 0 && i + i2 != i*2 && i + x >= 0 && i + x <= 8 && i2 + y >= 0 && i2 + y <= 8 
      end 
    end
    valid
  end

  def initialize(start)
      @root_node = PolyTreeNode.new(start)
      @considered_positions = [start]
      
  end

  def new_move_positions(pos)
    array = KnightPathFinder.valid_moves(pos)
    
    new_pos = []
    array.each do |ele|
      if !@considered_positions.include?(ele)
        @considered_positions << ele
        new_pos << ele
      end
    end
    new_pos

  end

  def build_move_tree
    queue = [@root_node]
  # debugger
    until queue.empty?
      # debugger
      node = queue.shift
      new_moves = new_move_positions(node.value)
      new_moves.each do |move|
        node.add_child(PolyTreeNode.new(move))
      end
      node.children.each do |child|
        queue.push(child)
        # debugger
      end
    end

  end

  def find_path(end_pos)
    self.build_move_tree  
    node = @root_node.bfs(end_pos)
    trace_path_back(node).reverse
  end

  def trace_path_back(node)
    array = [node.value]

    until node.parent == nil
      array << node.parent.value
      node = node.parent
    end
    array

  end
  


end
