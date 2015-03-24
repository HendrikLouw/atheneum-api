module Atheneum
  module Domain
    class Book
      attr_accessor :title
      attr_accessor :author
      attr_accessor :publisher
      attr_accessor :isbn
      attr_accessor :small_image
      attr_accessor :medium_image
      attr_accessor :large_image

      def Book.from_hash(hash)
        first_item = hash['ItemLookupResponse']['Items']['Item'].first
        attributes = first_item['ItemAttributes']

        Book.new title: attributes['Title'],
          author: attributes['Author'],
          publisher: attributes['Manufacturer'],
          isbn: first_item['ASIN'],
          small_image: first_item['SmallImage']['URL'],
          medium_image: first_item['MediumImage']['URL'],
          large_image: first_item['LargeImage']['URL']
      end

      def initialize( title:, author:, publisher:, isbn:,
                      small_image: nil, medium_image: nil,large_image: nil)
        @title = title
        @author = author.join(', ')
        @publisher = publisher
        @isbn = isbn
        @small_image = small_image
        @medium_image = medium_image
        @large_image = large_image
      end

      def to_h
        {
          title: @title,
          author: @author,
          publisher: @publisher,
          isbn: @isbn,
          small_image: @small_image,
          medium_image: @medium_image,
          large_image: @large_image
        }
      end
    end
  end
end