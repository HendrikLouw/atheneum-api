require 'test_helper'

describe 'BookISBN' do
  before do
    @vacuum_mock = MiniTest::Mock.new
    @vacuum_mock.expect :item_lookup, "<sample></sample>", [{
      query: {
        'SearchIndex' => BookISBN::SEARCH_INDEX,
        'IdType' => BookISBN::ID_TYPE,
        'ItemId' => '020161622X'
      }
    }]

  end
  let (:book_isbn) { @book_isbn = BookISBN.new code: '020161622X', lookup_service: @vacuum_mock }

  it 'should lookup a book by ISBN code' do
    book_isbn.lookup.must_be_instance_of Book
    @vacuum_mock.verify
  end
end
