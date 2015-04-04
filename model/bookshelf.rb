module Atheneum
  module Model
    class Bookshelf
      include Mongoid::Document
      belongs_to :user
      has_many :books

      def check_in(book: , library: )
        return false if library == nil || !library.checked_in?(book)
        library.check_out(book)
        self.books << book
        self.save
      end

      def check_out(book:)
        book.library.check_in(book)
        self.books.where(id: book.id).delete
        self.save
      end
    end
  end
end