require './rental'
require './person'

class Book
  # rubocop:disable Style/ClassVars
  @@books = []
  # rubocop:enable Style/ClassVars
  def initialize(title, author)
    @title = title
    @author = author
    @@books.push(self)
  end

  attr_accessor :title, :author

  def add_rental
    people = Person.class_variable_get(:@@people)
    puts 'Insert the number of the person that is renting'
    people.each_with_index { |person, index| puts "#{index + 1} | #{person.name}\n" }
    input_index = gets.chomp.to_i
    puts 'Insert date'
    date = gets.chomp.to_str
    Rental.new(date, self, people[input_index - 1])
  end
end
