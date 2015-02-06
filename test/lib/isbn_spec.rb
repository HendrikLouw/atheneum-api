require 'test_helper'

describe 'ISBN' do
  it 'should get a book title from an ISBN number' do
    isbn = ISBN.new number: '12345678'
    isbn.book_title.must_equal 'book'
  end
end
