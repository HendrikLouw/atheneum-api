require_relative '../spec_helper'

describe Atheneum::API::BookAPI do
  include Rack::Test::Methods

  def app
    Atheneum::API::LibraryAPI
  end

  describe "POST /v1/library/book/checkin" do
    it "should check in a book from supplied ISBN code" do
      expected_book = {
        "title"=>"The Pragmatic Programmer: From Journeyman to Master",
        "author"=>"Andrew Hunt, David Thomas",
        "publisher"=>"Addison-Wesley Professional",
        "isbn"=>"020161622X"
      }
      post "/v1/library/book/020161622X/check_in"
      last_response.status.must_equal 201
      JSON.parse(last_response.body).must_equal(expected_book)
    end
  end
end