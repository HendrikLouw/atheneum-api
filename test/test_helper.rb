require 'minitest/reporters'
require 'minitest/autorun'

require 'mocha/mini_test'

require 'json'
require './domain/book_isbn'
require './domain/book'
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


