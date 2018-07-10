require 'httparty'

class Recipe  #This is like a Model

  # base_uri 'api.edamam.com'  ### NOT SURE IF I NEED THIS?!?

  attr_reader :label, :image, :url, :id, :ingredients, :servings, :total_nutrients

  def initialize(label:, image:, url:, id:, ingredients:, servings:, total_nutrients: )
    raise ArgumentError if label == nil || label == ""

    @label = label
    @image = image
    @url = url
    @id = id

    @ingredients = ingredients
    @servings = servings
    @total_nutrients = total_nutrients

  end





end
