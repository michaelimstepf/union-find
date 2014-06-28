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
  # @param number_of_components [Integer] the number of components
  # @return [Integer] the number of components
  # @raise [ArgumentError] if number_of_components < 1
  def initialize(number_of_components)
    raise ArgumentError, 'number of components is < 1' if number_of_components < 1
    
    @number_of_components = number_of_components
    
    @parent = [] # parent of i
    @subtree_rank = [] # rank of subtree rooted at i (cannot be more than 31)
    number_of_components.times do |i|
      @parent[i] = i
      @subtree_rank[i] = 0
    end
  end

  # Returns the number of components.
  # @return [Interger] the number of components
  def count
    @number_of_components
  end

  # Returns the root of a component.
  # @param component_id [Integer] the integer representing one component
  # @return [Integer] the component_id of the root of a component
  # @raise [IndexError] unless 0 <= p < N (first component has index 0)
  def find_root(component_id)
    raise IndexError if (component_id < 0 || component_id >= @parent.length)
    
    while component_id != @parent[component_id] # stop at the top node where component id == parent id
      @parent[component_id] = @parent[@parent[component_id]] # path compression by halving
      component_id = @parent[component_id]
    end

    return component_id
  end

  # Do two components share the same root?
  # @param component_1_id [Integer] the integer representing one component
  # @param component_2_id [Integer] the integer representing the other component     
  # @return [Boolean]
  def connected?(component_1_id, component_2_id)
    find_root(component_1_id) == find_root(component_2_id)
  end



end

end