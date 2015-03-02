require_relative '../spec_helper'

describe Atheneum::API::BookAPI do
  include Rack::Test::Methods

  def app
    Atheneum::API::BookAPI
  end

  describe "GET /v1/book/lookup" do
    it "a book from supplied ISBN code" do
      expected_book = {
        "title"=>"The Pragmatic Programmer: From Journeyman to Master",
        "author"=>"Andrew Hunt, David Thomas",
        "publisher"=>"Addison-Wesley Professional",
        "isbn"=>"020161622X"
      }
      get "/v1/book/020161622X/lookup"
      last_response.status.must_equal 200
      JSON.parse(last_response.body).must_equal(expected_book)
    end
  end
end