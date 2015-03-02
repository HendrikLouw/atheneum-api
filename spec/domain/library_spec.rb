require_relative '../spec_helper'

include Atheneum::Domain

describe Atheneum::Domain::Library do
  let (:book) do
    Book.new title: 'The Pragmatic Programmer: From Journeyman to Master',
    author: ['Andrew Hunt', 'David Thomas'],
    publisher: 'Addison-Wesley Professional',
    isbn: '020161622X'
  end

  let(:library) { Library.new }

  it 'should check in a new book' do
    library.check_in(book: book).must_equal(book)
    library.checked_in_books.size.must_equal 1
    library.checked_in?(book).must_equal(true)
  end

  it 'should check out a book via isbn code' do
    library.check_in book: book
    library.check_out(isbn: '020161622X').must_equal(book)
    library.checked_in_books.size.must_equal 0
    library.checked_out_books.size.must_equal 1
    library.checked_out?(book).must_equal true
  end

  it 'should not allow checkout of non existing book' do
    library.check_out(isbn: '020161633X').must_be_nil
    library.checked_in_books.size.must_equal 0
    library.checked_out_books.size.must_equal 0
    library.checked_out?(book).must_equal false
  end
end
