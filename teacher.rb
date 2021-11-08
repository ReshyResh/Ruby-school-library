require './person'

class Teacher < Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', specialization = 'Default', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    super(age, name, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
