module Atheneum
  module Model
    class Book
      include Mongoid::Document
      field :title, :type => String
      field :isbn, :type => String
      field :author, :type => ArrayOrString
      field :publisher, :type => String
      field :small_image, :type => String
      field :medium_image, :type => String
      field :large_image, :type => String
      field :status, :type => String
      belongs_to :library


      def checked_in?
        self.status == "checked_in"
      end

      def check_in(library: )
        self.library = library
        self.status = "checked_in"
      end

      def check_in!(library: )
        self.check_in(library: library)
        self.save!
      end

      def checked_out?
        self.status == "checked_out"
      end

      def check_out(library: )
        self.library = library
        self.status = "checkout"
      end

      def check_out!(library: )
        self.check_out(library: library)
        self.save!
      end

      def Book.from_excon_response(response)
        Book.from_hash(response.to_h)
      end

      def to_h
        {
            :title => title,
            :isbn => isbn,
            :author => author,
            :publisher => publisher,
            :small_image => small_image,
            :medium_image => medium_image,
            :large_image => large_image
        }
      end

      private
      def Book.from_hash(hash)
        first_item = hash['ItemLookupResponse']['Items']['Item'].first
        attributes = first_item['ItemAttributes']
        Book.new :title => attributes['Title'],
                 :author => attributes['Author'],
                 :publisher => attributes['Manufacturer'],
                 :isbn => first_item['ASIN'],
                 :small_image => first_item['SmallImage']['URL'],
                 :medium_image => first_item['MediumImage']['URL'],
                 :large_image => first_item['LargeImage']['URL']
      end
    end
  end
end