require 'minitest/reporters'
require 'minitest/autorun'

require 'mocha/mini_test'

require 'vacuum'
require './lib/book_isbn'
require './lib/book'
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


