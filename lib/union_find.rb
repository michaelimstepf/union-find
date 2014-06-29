require 'union_find/version'

module UnionFind

# The UnionFind class represents a union-find data type
# (also known as the disjoint-sets data type).
# It supports the union and find operations,
# along with a connected operation for determinig whether
# two sites in the same component are connected and a count operation that
# returns the total number of components.

# This implementation uses weighted quick union by rank with path compression
# by halving.

# Initializing a data structure with number_of_components sites takes linear time.
# Afterwards, the union, find, and connected 
# operations take logarithmic time (in the worst case) and the
# count operation takes constant time.

# @author Robert Sedgewick
# @author Kevin Wayne
# @author Michael Imstepf
# @see http://algs4.cs.princeton.edu/15uf/UF.java.html
# @see http://algs4.cs.princeton.edu/15uf/
class UnionFind

  # Initializes an empty union-find data structure with
  # n isolated components 0 through n-1.
  # @param components [Array] components
  # @raise [ArgumentError] if components.length < 1 or if components is not an Array
  def initialize(components)
    raise ArgumentError, 'input is not an Array' unless components.class == Array   
    
    @number_of_components = components.length
    @number_of_unconnected_components = @number_of_components 

    raise ArgumentError, 'number of components is < 1' if components.length < 1         

    @parent = {} # parent of i
    @tree_size = {} # size of tree rooted at i (cannot be more than 31)
    components.each do |component|
      @parent[component] = component
      @tree_size[component] = 0
    end
  end

  # Returns the number of components.
  # @return [Interger] the number of components
  def count_components
    @number_of_components
  end

  # Returns the number of unconnected components.
  # @return [Interger] the number of unconnected components
  def count_unconnected_components
    @number_of_unconnected_components
  end  

  # Returns the root of a component.
  # @param component_id [Integer] the integer representing one component
  # @return [Integer] the component_id of the root of a component
  # @raise [IndexError] unless component exists
  def find_root(component)
    raise IndexError unless @parent[component]
    
    while component != @parent[component] # stop at the top node where component id == parent id
      @parent[component] = @parent[@parent[component]] # path compression by halving
      component = @parent[component]
    end

    return component
  end

  # Connect root of component 1 with root of component 2
  # by attaching smaller subtree root node with larger tree.
  # @param component_1_id [Integer] the integer representing one component
  # @param component_2_id [Integer] the integer representing the other component   
  def connect(component_1, component_2)
    root_component_1 = find_root(component_1)
    root_component_2 = find_root(component_2)

    return if root_component_1 == root_component_2

    # make smaller root point to larger one
    if @tree_size[root_component_1] < @tree_size[root_component_2]
      @parent[root_component_1] = root_component_2
      @tree_size[root_component_2] += @tree_size[root_component_1]
    else
      @parent[root_component_2] = root_component_1
      @tree_size[root_component_1] += @tree_size[root_component_2]
    end
    
    @number_of_unconnected_components -= 1
  end  

  # Do two components share the same root?
  # @param component_1 [Integer] the integer representing one component
  # @param component_2 [Integer] the integer representing the other component     
  # @return [Boolean]
  def connected?(component_1, component_2)
    find_root(component_1) == find_root(component_2)
  end




end

end