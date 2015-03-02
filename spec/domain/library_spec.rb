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
    library.check_in book: book
    library.books.size.must_equal 1
  end

  it 'should check out a book via isbn code' do
    library.check_in book: book
    library.check_out isbn: '020161622X'
    library.books.size.must_equal 0
  end
end
