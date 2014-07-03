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

# Initializing a data structure takes linear time.
# Afterwards, the union, find, and connected 
# operations take logarithmic time (in the worst case) and the
# count operation takes constant time.

# @author Robert Sedgewick
# @author Kevin Wayne
# @author Michael Imstepf
# @see http://algs4.cs.princeton.edu/15uf/UF.java.html
# @see http://algs4.cs.princeton.edu/15uf/
class UnionFind

  attr_accessor :components

  # Initializes an empty union-find data structure with
  # n isolated components 0 through n-1.
  # @param components [Array] components
  # @raise [ArgumentError] if components.length < 1 or if components is not an Array
  def initialize(components)
    # Unexpected behaviour,
    # for Sets the @components does not copy the content of components
    # rather it points to the components variable and any changes to the components
    # variables are reflected in @components.
    # Force copy instead.
    @components = components.dup

    raise ArgumentError, 'input is not a Set' unless @components.is_a? Set   

    @number_of_isolated_components = @components.length

    raise ArgumentError, 'number of components is < 1' if @number_of_isolated_components < 1         

    @parent = {} # parent of component
    @tree_size = {} # size of tree rooted at component (cannot be more than 31)
  end

  # Dynamically adds component.
  # @return [Component] component
  def add(component)
    if @components.add?(component)
      # if component does not already exist
      @number_of_isolated_components += 1
    end
  end

  # Returns the number of isolated components.
  # @return [Interger] the number of components
  def count_isolated_components
    @number_of_isolated_components
  end

  # Connect root of component 1 with root of component 2
  # by attaching smaller subtree root node with larger tree.
  # If both trees have the same size, the root of the second
  # component becomes a child of the root of the first component.
  # @param component_1 [Component] component
  # @param component_2 [Component] component
  # @return [Component, NilClass] the root of the larger tree or the root of the first component if both have the same tree size or nil if no connection has been made
  def union(component_1, component_2)
    root_component_1 = find_root(component_1)
    root_component_2 = find_root(component_2)

    # exit if already connected
    return nil if root_component_1 == root_component_2

    # make smaller root point to larger one
    if @tree_size[root_component_1] < @tree_size[root_component_2]
      @parent[root_component_1] = root_component_2
      root = root_component_2
      @tree_size[root_component_2] += @tree_size[root_component_1]
    else
      @parent[root_component_2] = root_component_1
      root = root_component_1
      @tree_size[root_component_1] += @tree_size[root_component_2]
    end
    
    @number_of_isolated_components -= 1

    root
  end  

  # Do two components share the same root?
  # @param component_1 [Component] component
  # @param component_2 [Component] component  
  # @return [Boolean]
  def connected?(component_1, component_2)
    find_root(component_1) == find_root(component_2)
  end

  private

  # Returns the root of a component.
  # @param component [Component] component
  # @return [Component] the root of the component
  # @raise [IndexError] unless component exists
  def find_root(component)
    raise IndexError, 'component does not exist' unless @components.include? component
    
    set_parent_and_tree_size(component)

    while component != @parent[component] # stop at the top node where component id == parent id
      @parent[component] = @parent[@parent[component]] # path compression by halving
      component = @parent[component]
    end

    return component
  end

  # Sets parent and tree size for each component.
  # To prevent initialize method from taking linear time,
  # this method is used to do this assignment on demand.
  # @param component [Component] component
  # @return [Component] component
  def set_parent_and_tree_size(component)    
    @parent[component] ||= component
    @tree_size[component] ||= 1
    component
  end  
end

end