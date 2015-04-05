require 'rack'
require_relative './atheneum'

class Atheneum::API::AllAPI < Grape::API
  mount Atheneum::API::BookAPI
  mount Atheneum::API::BookshelfAPI
end

run Atheneum::API::AllAPI