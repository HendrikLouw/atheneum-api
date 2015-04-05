include Atheneum::Model

RSpec.describe Atheneum::Model::Library do
  let(:library) do
    library = Library.new
    library.name = "ThoughtWorks JHB"
    library.save
    library
  end
  let(:book) { Book.new :title => "The Pragmatic Programmer: From Journeyman to Master",
                        :author => "Andrew Hunt",
                        :publisher => "Addison-Wesley Professional",
                        :isbn => "020161622X" }
  let(:book2) { Book.new :title => "The Pragmatic Programmer: From Journeyman to Master",
                         :author => "Andrew Hunt",
                         :publisher => "Addison-Wesley Professional",
                         :isbn => "020161622X" }

  context 'An empty library' do
    context 'Add a new book to the library' do
      it 'should add new books to the library checked in books' do
        VCR.use_cassette("library_check_in", :match_requests_on => [:method, :path, :host]) do
          expect(library.check_in(isbn: book.isbn)).to be(true)
          expect(library.checked_in?(isbn: book.isbn)).to be(true)
          expect(library.checked_in_book_count).to eq(1)
          expect(Book.count).to eq(1)

          expect(Book.find_by_isbn(book.isbn).first().library).to eq(library)
        end
      end

      it 'should not allow checking out a book that does not exist' do
        expect(library.check_out(isbn: book.isbn)).to be(false)
      end
    end
  end

  context 'Library with existing books' do
    before do
      VCR.use_cassette("library_existing_books", :match_requests_on => [:method, :path, :host]) do
        library.check_in(isbn: book.isbn)
      end
    end

    it 'should checkout existing books' do
      expect(library.check_out(isbn: book.isbn)).to be true
      expect(library.checked_in?(isbn: book.isbn)).to be false
      expect(library.checked_in_book_count).to eq 0
    end
  end
end