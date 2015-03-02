require 'grape'
require_relative '../domain/book_isbn'

module Atheneum
  module API
    class LibraryAPI < ::Grape::API
      version 'v1', using: :path
      format :json
      default_format :json

      namespace :library do
        namespace :book do
          route_param :isbn_code do
            post :check_in do
              library = Atheneum::Domain::Library.new
              book_isbn = Atheneum::Domain::BookISBN.new code: params[:isbn_code]
              book = book_isbn.lookup
              checked_in_book = library.check_in book: book
              checked_in_book.to_h
            end
          end
        end
      end
    end
  end
end