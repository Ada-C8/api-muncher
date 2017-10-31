class Recipe
  attr_reader :search_term

  def initialize(search_term)
    raise ArgumentError if search_term == nil
    @search_term = search_term

  end
end
