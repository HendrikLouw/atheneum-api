require 'vacuum'
require 'json'
require 'mongoid'

require_relative './mongoid_ext/array_or_string'

require_relative './model/book'

require_relative './domain/book_isbn'
require_relative './domain/library'

require_relative './api/book_api'

Mongoid.load!("config/mongoid.yml")