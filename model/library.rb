module Atheneum
  module Model
    class Library
      include Mongoid::Document
      field :name, :type => String
      has_many :books

      def check_in(book)
        self.books << book
        book.check_in!
      end

      def check_out(book)
        if checked_in?(book)
          book.check_out!
          true
        else
          false
        end
      end

      def checked_in?(book)
        book.library == self && book.checked_in?
      end

      def checked_out?(book)
        book.library == self && book.checked_out?
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