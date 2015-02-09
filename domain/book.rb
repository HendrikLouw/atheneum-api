module Atheneum
  module Domain
    class Book
      attr_accessor :title
      attr_accessor :author
      attr_accessor :publisher

      def Book.from_hash(hash)
        attributes = hash['ItemLookupResponse']['Items']['Item'].first['ItemAttributes']

        Book.new title: attributes['Title'],
          author: attributes['Author'],
          publisher: attributes['Manufacturer']
      end

      def initialize(title:, author:, publisher:)
        @title = title
        @author = author.join(', ')
        @publisher = publisher
      end


      def to_h
        {
          title: @title,
          author: @author,
          publisher: @publisher
        }
      end
    end
  end
end