class Recipe
  attr_reader :title, :mini_uri, :photo_uri, :external_url, :source, :ingredients

  RECIPE_URL = "http://www.edamam.com/ontologies/edamam.owl%23recipe_"
  def initialize( title, uri, photo_uri, ingredients, options = { } )
    @title = title
    @mini_uri = uri[RECIPE_URL.length-2,uri.length]
    @photo_uri = photo_uri
    @ingredients = ingredients
    @external_url = options[:external_url]
    @source = options[:source]
  end

end
