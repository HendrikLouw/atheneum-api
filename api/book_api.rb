require 'grape'
require_relative '../domain/book_lookup'

module Atheneum
  module API
    class BookAPI < ::Grape::API
      version 'v1', using: :path
      format :json
      default_format :json

      namespace :book do
        route_param :isbn_code do
          get :lookup do
            book_isbn = Atheneum::Domain::BookLookup.new isbn_code: params[:isbn_code]
            book_isbn.lookup.to_h
          end
        end
      end
    end
  end
end