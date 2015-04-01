include Atheneum::Domain

RSpec.describe Atheneum::Domain::Library do
  context 'An empty library' do
    let(:library) do
      Library.new
    end

    describe 'Add a new book to the library' do
      let(:book) { Book.new :title => "The Pragmatic Programmer: From Journeyman to Master",
                            :author => "Andrew Hunt",
                            :publisher => "Addison-Wesley Professional",
                            :isbn => "020161622X" }

      it 'should add new books to the library checked in books' do
        library.add book
        expect(library.checked_in?(book)).to be true
        expect(library.checked_in_book_count).to eq(1)
        expect(Book.count).to eq(1)
      end
    end
  end
end