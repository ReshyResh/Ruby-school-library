class Classroom
  # rubocop:disable Style/ClassVars
  @@classes_name = []
  @@classes_object = []
  # rubocop:enable Style/ClassVars

  def initialize(label)
    @label = label.downcase
    @students = []
    @@classes_name.push(@label)
    @@classes_object.push(self)
  end

  attr_accessor :label
  attr_reader :students

  def add_student(student)
    student.classroom = @label
  end
end
