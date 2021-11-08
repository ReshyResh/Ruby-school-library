require './person'

class Student < Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', classroom = 'Default', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
