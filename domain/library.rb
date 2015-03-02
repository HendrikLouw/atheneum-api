module Atheneum
  module Domain
    class Library
      attr_accessor :books

      def initialize
        @books = []
      end

      def check_in book:
        @books << book
      end

      def check_out isbn:
        book = @books.bsearch { |book| book.isbn == isbn}
        @books.delete( book )
      end
    end
  end
end