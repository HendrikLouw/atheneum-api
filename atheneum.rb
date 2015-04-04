require 'vacuum'
require 'json'
require 'mongoid'

require_relative './mongoid_ext/array_or_string'

require_relative './model/book'
require_relative './model/library'
require_relative './model/bookshelf'
require_relative './model/user'

require_relative './domain/book_lookup'

require_relative  './api/book_api'

Mongoid.load!(File.dirname(__FILE__) + '/config/mongoid.yml')