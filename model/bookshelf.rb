module Atheneum
  module Model
    class Bookshelf
      include Mongoid::Document
      belongs_to :user
      has_many :books

      def scan(book:, library:)
        if self.checked_in?(book: book)
          return check_out(book: book, library: library)
        else
          return check_in(book: book, library: library)
        end
      end

      def checked_in?(book: )
        self.books.where(id: book.id).first() != nil
      end

      private
      def check_in(book: , library: )
        return false if self.checked_in?(book: book)

        if library.checked_in?(book: book)
          library.check_out(book: book)
          self.books << book
          return self.save
        else
          library.check_in(book: book)
          return true
        end

      end

      def check_out(book:, library:)
        library.check_in(book: book)
        self.books.where(id: book.id).delete
        self.save
      end
    end
  end
end