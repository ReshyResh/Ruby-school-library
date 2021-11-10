class Rental
  # rubocop:disable Style/ClassVars
  @@rentals = []
  # rubocop:enable Style/ClassVars
  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @@rentals.push(self)
  end

  attr_accessor :date
  attr_reader :book, :person
end
