class Recipe
  attr_reader :title, :mini_uri, :photo_uri, :external_url, :source, :ingredients

  def initialize( title, uri, photo_uri, ingredients, options = { } )
    @title = title
    @mini_uri = uri[EdamamApiWrapper::RECIPE_URL.length-2,uri.length]
    @photo_uri = photo_uri
    @ingredients = ingredients
    @external_url = options[:external_url]
    @source = options[:source]
  end

  def == (another_recipe)
    self.title == another_recipe.title
    self.mini_uri == another_recipe.mini_uri
    self.photo_uri == another_recipe.photo_uri
    self.ingredients == another_recipe.ingredients
    self.external_url == another_recipe.external_url
    self.source == another_recipe.source
  end

end
