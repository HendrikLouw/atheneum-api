module Atheneum
  module Domain
    include Atheneum::Model
    class Library
      def initialize()
        @checked_in_books = []
      end

      def add(book)
        book.save
        @checked_in_books << book
      end

      def checked_in_books
        @checked_in_books
      end
    end
  end
end