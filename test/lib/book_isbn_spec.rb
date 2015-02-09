require 'test_helper'

describe 'BookISBN' do
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

    @vacuum_mock.verify
  end
end
