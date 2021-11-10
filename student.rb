require './person'
require './classroom'
require './corrector'

class Student < Person
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', classroom = 'Default', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    raise TypeError.new "Invalid age input, must be int" unless age.is_a? Integer
    raise TypeError.new "Invalid name input, must be string" unless name.is_a? String
    raise TypeError.new "Invalid classroom input, must be string" unless name.is_a? String
    raise TypeError.new "Invalid boolean input" unless parent_permission == true || parent_permission == false
    super(age, name, parent_permission)
    @helper = Corrector.new
    @classroom = @helper.lowercase(classroom)
    
    def check
       classes_names = Classroom.class_variable_get(:@@classes_name)
       classes_objects = Classroom.class_variable_get(:@@classes_object)

       classes_names.include?(@classroom) ? 
       [(puts"Student added to existing classroom"), classes_objects[classes_names.find_index(@classroom)].students.push(self)] : 
       [(puts"New classroom created"), new_class = Classroom.new(@classroom),new_class.label = @classroom,  new_class.students.push(self)]

       classes_objects.each { |n|
        n.students.each { |student| 
          student.classroom != n.label ? n.students.delete(student) : nil
        }
      }
    end
    check
  end
  attr_reader :students
  attr_accessor :classroom

  def classroom=(classroom)
    @classroom = classroom.downcase
    check
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end