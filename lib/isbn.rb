class ISBN
  def initialize(params = {})
    @isbn = params[:isbn]
  end

  def book_title
    "book"
  end
end
