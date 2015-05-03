require 'grape'

module Atheneum
  module API
    class LibraryAPI < ::Grape::API
      version 'v1', using: :path
      format :json
      default_format :json

      namespace :library do
        route_param :library_id do
          get :checked_in do
            library = Atheneum::Model::Library.find(params[:library_id])
            library.books.checked_in.all()
          end
        end
      end
    end
  end
end