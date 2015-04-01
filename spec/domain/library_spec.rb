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

      # it 'should add new books the the library checked in books' do
      #   library.add book
      #   library.checked_in_books.must_equal [book]
      #   Book.any_instance.expects(:save)
      # end

    end
  end
end