require './person'

class Teacher < Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', specialization = 'Default', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    raise TypeError, 'Invalid age input, must be int' unless age.is_a? Integer
    raise TypeError, 'Invalid name input, must be string' unless name.is_a? String
    raise TypeError, 'Invalid Specialization input, must be string' unless name.is_a? String
    raise TypeError, 'Invalid boolean input' unless [true, false].include?(parent_permission)

    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
