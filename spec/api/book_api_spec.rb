RSpec.describe Atheneum::API::BookAPI do
  include Rack::Test::Methods

  def app
    Atheneum::API::BookAPI
  end

  context "GET /v1/book/{isbn_code}/lookup" do
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

  # context "POST /v1/book/{isbn_code}/scan" do
  #
  #   context "Scanned book not in the library" do
  #     context "No books in the users bookshelf" do
  #       it "should check in a new book to the library" do
  #         pending "A bookshelf"
  #       end
  #
  #       context "Scanned book is in the user's bookshelf" do
  #         it "should check in an existing book to the library" do
  #           pending "A bookshelf"
  #         end
  #       end
  #     end
  #   end
  #
  #
  #   context "Scanned book in the library" do
  #     context "No books in the users bookshelf" do
  #       it "should check out the book form the library and add it to the user's bookshelf" do
  #         pending "A bookshelf"
  #       end
  #
  #     end
  #
  #     context "Scanned Book in the users bookshelf" do
  #       it "should check in the scanned book to the library" do
  #         pending "A bookshelf"
  #       end
  #     end
  #   end

  # end
end
