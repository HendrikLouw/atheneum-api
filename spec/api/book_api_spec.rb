RSpec.describe Atheneum::API::BookAPI do
  include Rack::Test::Methods

  def app
    Atheneum::API::BookAPI
  end

  context "GET /v1/book/lookup" do
    it "a book from supplied ISBN code" do
      expected_book = {
          "title" => "The Pragmatic Programmer: From Journeyman to Master",
          "author" => "Andrew Hunt, David Thomas",
          "publisher" => "Addison-Wesley Professional",
          "isbn" => "020161622X",
          "small_image" => "http://ecx.images-amazon.com/images/I/41BKx1AxQWL._SL75_.jpg",
          "medium_image" => "http://ecx.images-amazon.com/images/I/41BKx1AxQWL._SL160_.jpg",
          "large_image" => "http://ecx.images-amazon.com/images/I/41BKx1AxQWL.jpg"
      }

      VCR.use_cassette("lookup020161622", :match_requests_on => [:method, :path, :host ]) do
        get "/v1/book/020161622X/lookup"
        expect(last_response.status).to eq(200)
        expect(JSON.parse(last_response.body)).to eq(expected_book)
      end
    end
  end
end
