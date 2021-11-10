class Rental
    @@rentals = []
    def initialize(date, book, person)
        @date = date
        @book = book
        @person = person
        @@rentals.push(self)
    end

    attr_accessor :date
    attr_reader :book, :person
end