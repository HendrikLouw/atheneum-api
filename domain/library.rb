module Atheneum
  module Domain
    class Library
      attr_accessor :checked_in_books
      attr_accessor :checked_out_books

      def initialize
        @checked_in_books = []
        @checked_out_books = []
      end

      def check_in book:
        @checked_in_books << book
        book
      end

      def check_out isbn:
        book = @checked_in_books.bsearch { |book| book.isbn == isbn }
        return nil if !checked_in?(book)

        @checked_in_books.delete( book )
        @checked_out_books << book
        book
      end

      def checked_in?(book)
        @checked_in_books.include?(book)
      end

      def checked_out?(book)
        @checked_out_books.include?(book)
      end
    end
  end
end