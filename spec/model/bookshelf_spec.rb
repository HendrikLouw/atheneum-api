include Atheneum::Model

RSpec.describe Atheneum::Model::Bookshelf do
  let(:bookshelf) { Bookshelf.create! }

  let(:book1) { Book.new :title => "The Pragmatic Programmer: From Journeyman to Master",
                        :author => "Andrew Hunt",
                        :publisher => "Addison-Wesley Professional",
                        :isbn => "020161622X" }
  let(:book2) { Book.new :title => "The Pragmatic Programmer: From Journeyman to Master",
                         :author => "Andrew Hunt",
                         :publisher => "Addison-Wesley Professional",
                         :isbn => "020161622X" }

  context "Empty library" do
    let(:library) { Library.create!(name: "TW Johannesburg") }

    context "Empty bookshelf" do
      it "should not do anything" do
        expect(bookshelf.check_in(book: book1, library: library)).to eq false
      end
    end
  end

  context "Library with books" do
    let(:library) do
      library = Library.create!(name: "TW Johannesburg")
      library.check_in(book1)
      library.check_in(book2)
      library
    end

    it "should add an existing book to the bookshelf and check it out of the library" do
      expect(bookshelf.check_in(book: book1, library: library)).to eq true
      expect(library.checked_out?(book1)).to eq true

      expect(bookshelf.check_in(book: book2, library: library)).to eq true
      expect(library.checked_out?(book2)).to eq true
    end

    it 'should remove books from the bookshelf and check it in to the library' do
      bookshelf.check_in(book: book1, library: library)
      bookshelf.check_in(book: book2, library: library)

      expect(bookshelf.check_out(book: book1)).to eq true
      expect(library.checked_in?(book1)).to eq true
      expect(bookshelf.check_out(book: book2)).to eq true
      expect(library.checked_in?(book2)).to eq true
    end
  end

end