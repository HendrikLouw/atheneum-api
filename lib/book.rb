require 'active_support/core_ext/hash/conversions'

class Book
  attr_accessor :title

  def Book.from_hash(hash)
    attributes = hash['ItemLookupResponse']['Items']['Item'].first['ItemAttributes']
    Book.new title: attributes['Title']
  end

  def initialize(title:)
    @title = title
  end

end