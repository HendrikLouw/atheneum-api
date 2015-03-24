module Atheneum
  module Domain
    class BookISBN
      SEARCH_INDEX = 'Books'
      ID_TYPE = 'ISBN'
      ASSOCIATE_TAG='tag'

      def initialize(code:, lookup_service: initialize_default_lookup_service)
        @isbn = code
        @lookup_service = lookup_service
      end

      def lookup
        raw_product_lookup_response = @lookup_service.item_lookup(
          query: {
            'SearchIndex' => SEARCH_INDEX,
            'IdType' => ID_TYPE,
            'ItemId' => @isbn,
            'ResponseGroup' => 'Small, Images'
          })

        Book.from_hash raw_product_lookup_response.to_h
      end

      private
      def initialize_default_lookup_service
        lookup_service = Vacuum.new
        lookup_service.configure associate_tag: ASSOCIATE_TAG
        lookup_service
      end
    end
  end
end