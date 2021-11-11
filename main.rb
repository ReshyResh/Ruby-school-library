require './classroom'
require './student'
require './teacher'
require './person'
require './book'
require './rental'
# rubocop:disable Metrics, Lint
class App
  def initialize
    @classroom_names = Classroom.class_variable_get(:@@classes_name)
    @classrooms = Classroom.class_variable_get(:@@classes_object)
    @books = Book.class_variable_get(:@@books)
    @people = Person.class_variable_get(:@@people)
    @rentals = Rental.class_variable_get(:@@rentals)
    puts 'Initializing'
  end

  def run
    puts 'Welcome to School Library App!'
    loop do
      puts "
1 | List all books
2 | List all people
3 | Create a person
4 | Create a book
5 | Create a rental
6 | List all rentals
7 | List all rentals for a given person id
8 | List all classrooms
9 | Create a new classroom
10 | List all students for a given classroom
11| Change a student's classroom
12| Exit"
      puts "\nSelect an option: "
      user_input = gets.chomp.to_i
      break if user_input >= 12

      puts "\n"
      options user_input
    end
  end

  def options(input)
    case input
    when 1
      list_books
    when 2
      list_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals
    when 7
      list_rentals_id
    when 8
      list_classrooms
    when 9
      create_classroom
    when 10
      list_students_classroom
    when 11
      change_classroom
    else
      puts 'Invalid input'
    end
  end

  def list_books
    puts '-' * 70
    if @books.length.zero?
      (puts 'Book list is empty')
    else
      @books.each_with_index do |book, index|
        puts "#{index + 1} | #{book.title} - By #{book.author}"
      end
    end
    puts '-' * 70
  end

  def list_people
    puts '-' * 70
    if @people.length.zero?
      (puts 'No person registered!')
    else
      @people.each_with_index do |person, index|
        puts "#{index + 1} | #{person.name} - #{person.age} years old"
      end
    end
    puts '-' * 70
  end

  def create_person
    option = ''
    age = ''
    loop do
      puts "Do you want to create a student (1) or a teacher (2)? [Input the number]\n"
      option = gets.chomp.to_i
      break if [1, 2].include?(option)
    end
    loop do
      puts 'Age:'
      age = gets.chomp.to_i
      break if age.is_a? Integer and age.positive?
    end

    puts 'Name:'
    name = gets.chomp
    case option
    when 1
      permission = ''
      loop do
        puts 'Has parent permission? [Y/N]'
        permission = gets.chomp.downcase
        break if %w[y n].include?(permission)
      end
      def perm_helper(inp)
        case inp
        when 'y'
          true
        when 'n'
          false
        end
      end
      puts 'Assign a classroom to the student:'
      classroom = gets.chomp
      s = Student.new(age, name, classroom, perm_helper(permission))
      puts "Student #{s.name} created succesfully!"
    when 2
      puts 'Assign a specialization to the teacher:'
      specialization = gets.chomp
      s = Teacher.new(age, name, specialization)
      puts "Teacher #{s.name} created succesfully!"
    end
  end

  def create_classroom
    puts 'Insert the name of the classroom: '
    classroom = gets.chomp
    s = Classroom.new(classroom)
    puts "Classroom #{s.label} created!"
  end

  def create_book
    puts 'Title: '
    title = gets.chomp
    puts 'Author: '
    author = gets.chomp
    s = Book.new(title, author)
    puts "#{s.title} created succesfully!"
  end

  def create_rental
    option_book = ''
    option_person = ''
    loop do
      puts 'Select a book from the list: '
      list_books
      option_book = gets.chomp.to_i - 1
      break if @books[option_book] and (option_book + 1).positive?
    end
    loop do
      puts "Select the person that is renting #{@books[option_book].title}: "
      list_people
      option_person = gets.chomp.to_i - 1
      break if @people[option_person] and (option_person + 1).positive?
    end
    puts 'Date: '
    date = gets.chomp
    s = Rental.new(date, @books[option_book], @people[option_person])
    puts "Rental for #{@people[option_person].name} created succesfully!"
  end

  def list_rentals
    puts '-' * 70
    if @rentals.length.zero?
      (puts 'No rental registered!')
    else
      @rentals.each_with_index do |rental, index|
        puts "#{index + 1} | #{rental.person.name} has rented #{rental.book.title} on #{rental.date}"
      end
    end
    puts '-' * 70
  end

  def list_rentals_id
    if @rentals.length.zero?
      puts "Can't show by id, no rental is present!"
    else
      id = ''
      loop do
        puts 'Select a person to show their rentals'
        list_people
        id = gets.chomp.to_i - 1
        break if id <= @people.length and (id + 1).positive?
      end
      arr = @rentals.select { |rental| rental.person == @people[id] }
      puts '-' * 70
      if arr.length.zero?
        (puts "No rental registered for #{@people[id].name}!")
      else
        arr.each_with_index do |rental, index|
          puts "#{index + 1} | #{rental.book.title} on #{rental.date}"
        end
      end
      puts '-' * 70
    end
  end

  def list_classrooms
    puts '-' * 70
    if @classrooms.length.zero?
      (puts 'No classroom registered!')
    else
      @classrooms.each_with_index do |classroom, index|
        puts "#{index + 1} | #{classroom.label} | Students: #{classroom.students.length}"
      end
    end
    puts '-' * 70
  end

  def list_students_classroom
    if @classrooms.length.zero?
      puts 'No classrooms to be shown!'
    else
      option = ''
      loop do
        puts 'Select a classroom to show its students'
        list_classrooms
        option = gets.chomp.to_i - 1
        break if @classrooms[option] and (option + 1).positive?
      end
      puts '-' * 70
      puts "Students for #{@classrooms[option].label}:"
      @classrooms[option].students.each { |student| puts "#{student.name} - #{student.age} years old" }
      puts '-' * 70
    end
  end

  def change_classroom
    ids = []
    @classrooms.each do |classroom|
      classroom.students.each do |student|
        puts "#{student.id} | #{student.name} | Current class: #{student.classroom}"
        ids.push(student.id)
      end
    end
    input = ''
    loop do
      puts 'Select the ID of the student that you want to move'
      input = gets.chomp.to_i
      break if ids.include?(input)
    end
    stud_arr = @people.select { |person| person.id == input }
    stud = stud_arr[0]
    puts "Select a new classroom for the student #{stud.name}"
    list_classrooms
    option = gets.chomp.to_i - 1
    stud.classroom = @classrooms[option].label
    puts "Student #{stud.name} succesfully moved to classroom #{@classrooms[option].label}"
  end
end

def main
  app = App.new
  Book.new('Lord of the rings', 'Tolkien')
  Book.new('Harry Potter', 'Rowling')
  Book.new('Rich dad poor dad', 'Kiyosaki')
  Book.new('Atomic habits', 'Clear')
  Student.new(15, 'Mark', 'Maths')
  Student.new(18, 'Sofia', 'Physics')
  Student.new(10, 'James', 'Maths')
  Student.new(16, 'Barbara', 'Electronics')
  Student.new(17, 'Chad', 'Bathroom')
  Teacher.new(45, 'Pedro', 'English language')
  Teacher.new(56, 'Manuela', 'Laws')
  Teacher.new(65, 'George', 'Electronics')
  app.run
end
# rubocop:enable Metrics, Lint
main
