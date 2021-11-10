require './rental'
require './book'

class Person
  @@people = []
  # rubocop:disable Style/OptionalBooleanParameter
  def initialize(age, name = 'Unknown', parent_permission = true)
    # rubocop:enable Style/OptionalBooleanParameter
    raise TypeError.new "Invalid age input, must be int" unless age.is_a? Integer
    raise TypeError.new "Invalid name input, must be string" unless name.is_a? String
    raise TypeError.new "Invalid boolean input" unless parent_permission == true || parent_permission == false
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @helper = Corrector.new
    @@people.push(self)
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

  def add_rental
    books = Book.class_variable_get(:@@books)
    puts "Insert the number of the book that #{self.name} is renting"
    books.each_with_index { |book,index| puts "#{index+1} | #{book.title} - By #{book.author}\n"}
    input_index = gets.chomp.to_i
    puts "Insert date"
    date = gets.chomp.to_str
    Rental.new(date, books[input_index-1], self)
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
require './classroom'
require 'pry'
def start
  marco = Person.new(15,"Marco")
  polo = Person.new(16,"Polo")
  book1 = Book.new("Game of","Thrones")
  book2 = Book.new("Harry","Potter")
  binding.pry
end
start


