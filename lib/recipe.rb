class Recipe
  attr_reader :title, :uri, :photo_uri, :external_url, :source, :ingredients

  def initialize(title, uri, external_url, photo_uri, source, ingredients)
    # TODO: Decide how to handle receiving information that may not be supplied by API.
    # raise ArgumentError if title == nil || title == ""

    @title = title
    @uri = uri
    @external_url = external_url
    @photo_uri = photo_uri
    @source = source
    @ingredients = ingredients
  end
end
