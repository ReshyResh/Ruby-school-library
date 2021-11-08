require './person'

class Teacher < Person
  def initialize(age, name = 'Unknown', specialization = 'Default')
    super(age, name)
    @specialization = specialization
    @parent_permission = true
  end
end
