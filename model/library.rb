module Atheneum
  module Model
    class Library
      include Mongoid::Document
      field :name, :type => String
      has_many :books

      def check_in(isbn:)
        book = self.books.find_by_isbn(isbn).first()

        if !book
          book = Atheneum::Domain::BookLookup.new(isbn: isbn).lookup
          self.books << book
        end
        book.check_in!
      end

      def check_out(isbn:)
        if checked_in?(isbn: isbn)
          book = self.books.find_by_isbn(isbn).first()
          book.check_out!
          true
        else
          false
        end
      end

      def checked_in?(isbn:)
        book_with_isbn = self.books.where(isbn: isbn, status: Book::CHECKED_IN).first()
        book_with_isbn != nil
      end

      def checked_out?(isbn:)
        book_with_isbn = self.books.where(isbn: isbn, status: Book::CHECKED_OUT).first()
        book_with_isbn != nil
      end

      def checked_in_book_count
        self.books.checked_in.count()
      end

      def to_h
        {
            :name => name
        }
      end
    end
  end
end