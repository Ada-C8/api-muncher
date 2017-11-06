class Recipe
  attr_reader :title, :uri_hash, :photo_uri, :external_url, :source, :ingredients, :labels

  def initialize( title, uri, photo_uri, ingredients, options = { } )
    @title = title
    @uri_hash = uri.split("_").last
    @photo_uri = photo_uri
    @ingredients = ingredients
    @external_url = options[:external_url]
    @source = options[:source]
    @labels = options[:labels]

  end

  def == (another_recipe)
    self.title == another_recipe.title &&
    self.uri_hash == another_recipe.uri_hash &&
    self.photo_uri == another_recipe.photo_uri &&
    self.ingredients == another_recipe.ingredients &&
    self.external_url == another_recipe.external_url &&
    self.source == another_recipe.source &&
    self.labels == another_recipe.labels
  end

end
