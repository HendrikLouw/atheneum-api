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

      def checked_in?(book)
        @checked_in_books.include? book
      end

      def checked_in_book_count
        @checked_in_books.size
      end
    end
  end
end
