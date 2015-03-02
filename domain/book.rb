module Atheneum
  module Domain
    class Book
      attr_accessor :title
      attr_accessor :author
      attr_accessor :publisher
      attr_accessor :isbn

      def Book.from_hash(hash)
        first_item = hash['ItemLookupResponse']['Items']['Item'].first
        attributes = first_item['ItemAttributes']

        Book.new title: attributes['Title'],
          author: attributes['Author'],
          publisher: attributes['Manufacturer'],
          isbn: first_item['ASIN']
      end

      def initialize(title:, author:, publisher:, isbn:)
        @title = title
        @author = author.join(', ')
        @publisher = publisher
        @isbn = isbn
      end

      def to_h
        {
          title: @title,
          author: @author,
          publisher: @publisher,
          isbn: @isbn
        }
      end
    end
  end
end