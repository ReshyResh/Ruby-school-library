require './person'

class Teacher < Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', specialization = 'Default', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    raise TypeError.new "Invalid age input, must be int" unless age.is_a? Integer
    raise TypeError.new "Invalid name input, must be string" unless name.is_a? String
    raise TypeError.new "Invalid Specialization input, must be string" unless name.is_a? String
    raise TypeError.new "Invalid boolean input" unless parent_permission == true || parent_permission == false
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
