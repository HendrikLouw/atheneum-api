require 'minitest/reporters'
require 'minitest/autorun'

require 'mocha/mini_test'

require 'rack/test'

require 'json'

require_relative '../atheneum'

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]


