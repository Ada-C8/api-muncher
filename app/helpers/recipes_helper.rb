module RecipesHelper
  def self.get_from_and_to(page)
    from = (page*10) - 10
    to = (page*10)
    return from, to
  end
end
