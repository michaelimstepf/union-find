require 'set'

class Family
  attr_accessor :people

  def initialize(people)
    @people = people
  end
end

people = Set.new ['Grandfather', 'Father', 'Mother', 'Son', 'Daughter']

family = Family.new(people)

people << 'Grandmother'

puts family.people.include? 'Grandmother'
puts people.include? 'Grandmother'