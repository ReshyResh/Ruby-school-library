class Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @helper = Corrector.new
  end
  attr_reader :id
  attr_accessor :name, :age

  def can_use_services?
    return false unless of_age? or @parent_permission == true

    true
  end

  def validate_name
    @name = @helper.correct_name(@name)
  end

  private

  def of_age?
    return false unless @age >= 18

    true
  end
end

require './student'
require './teacher'
require './corrector'
