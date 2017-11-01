class Recipe
  attr_reader :title, :uri, :photo_uri, :external_url, :source, :ingredients

  def initialize( title, uri, photo_uri, ingredients, options = { } )
    @title = title
    @uri = uri
    @photo_uri = photo_uri
    @ingredients = ingredients
    @external_url = options[:external_url]
    @source = options[:source]
  end
end
