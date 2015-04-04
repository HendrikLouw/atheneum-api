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
        expect(library.add(book)).to be(true)
        expect(library.checked_in?(book)).to be(true)
        expect(library.checked_in_book_count).to eq(1)
        expect(Book.count).to eq(1)
        expect(book.library).to eq(library)

        library.add book2
        expect(library.checked_in?(book)).to be true
        expect(library.checked_in_book_count).to eq(2)
        expect(Book.count).to eq(2)
        expect(book2.library).to eq(library)
      end

      it 'should not allow checking out a book that does not exist' do
        expect(library.checkout(book)).to be(false)
      end
    end
  end

  context 'Library with existing books' do
    before do
      library.add(book)
      library.add(book2)
    end

    it 'should checkout existing books' do
      expect(library.checkout(book)).to be true
      expect(library.checked_in?(book)).to be false
      expect(library.checked_in_book_count).to eq 1

      expect(library.checkout(book2)).to be true
      expect(library.checked_in?(book2)).to be false
      expect(library.checked_in_book_count).to eq 0
    end
  end
end