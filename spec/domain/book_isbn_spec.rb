require_relative '../spec_helper'

include Atheneum::Domain

describe Atheneum::Domain::BookISBN do
  before do
    json_file = File.join(File.expand_path(File.dirname(__FILE__)), 'item_lookup.json')
    sample_json = File.read(json_file)

    class FakeLookup
      def initialize(json)
        @json = json
      end

      def to_h
        JSON.parse @json
      end
    end

    @vacuum_mock = MiniTest::Mock.new
    @vacuum_mock.expect :item_lookup, FakeLookup.new(sample_json), [{
      query: {
        'SearchIndex' => BookISBN::SEARCH_INDEX,
        'IdType' => BookISBN::ID_TYPE,
        'ItemId' => '020161622X'
      }
    }]
  end

  let (:book_isbn) { @book_isbn = BookISBN.new code: '020161622X', lookup_service: @vacuum_mock }

  it 'should lookup a book by ISBN code' do
    book = book_isbn.lookup
    book.must_be_instance_of Book
    book.title.must_equal 'The Pragmatic Programmer: From Journeyman to Master'
    book.author.must_equal 'Andrew Hunt, David Thomas'
    book.publisher.must_equal 'Addison-Wesley Professional'
    book.isbn.must_equal '020161622X'

    @vacuum_mock.verify
  end
end
