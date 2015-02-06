require 'minitest/reporters'
require 'minitest/autorun'

require './lib/isbn'
reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


