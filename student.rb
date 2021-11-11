require './person'
require './classroom'
require './corrector'

class Student < Person
  # rubocop:disable Style/OptionalBooleanParameter, Metrics, Lint
  def initialize(age, name = 'Unknown', classroom = 'Default', parent_permission = true)
    raise TypeError, 'Invalid age input, must be int' unless age.is_a? Integer
    raise TypeError, 'Invalid name input, must be string' unless name.is_a? String
    raise TypeError, 'Invalid classroom input, must be string' unless name.is_a? String
    raise TypeError, 'Invalid boolean input' unless [true, false].include?(parent_permission)

    super(age, name, parent_permission)
    @helper = Corrector.new
    @classroom = @helper.lowercase(classroom)

    def check
      classes_names = Classroom.class_variable_get(:@@classes_name)
      classes_objects = Classroom.class_variable_get(:@@classes_object)

      if classes_names.include?(@classroom)
        classes_objects[classes_names.find_index(@classroom)].students.push(self)
      else
        [new_class = Classroom.new(@classroom), new_class.label = @classroom,
         new_class.students.push(self)]
      end

      classes_objects.each do |n|
        n.students.each do |student|
          student.classroom == n.label ? nil : n.students.delete(student)
        end
      end
    end
    check
  end
  attr_reader :students
  attr_accessor :classroom

  def classroom=(classroom)
    @classroom = classroom.downcase
    check
  end

  # rubocop:enable Style/OptionalBooleanParameter, Metrics, Lint
  def play_hooky
    "¯\(ツ)/¯"
  end
end
