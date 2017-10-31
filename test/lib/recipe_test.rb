require 'test_helper'

describe "Recipe" do
  before do
    @name = "name"
    @image = "image"
    @url = "url"
    @ingredients = ["ingredients"]
    @recipe = Recipe.new(@name, @image, @url, @ingredients)
  end
  it "can be instantiated" do
    @recipe.must_be_kind_of Recipe
  end

  it "Requires a name, image, url, and ingredients" do
    proc {
      Recipe.new()
    }.must_raise ArgumentError

    proc {
      Recipe.new("name", "image", "url")
    }.must_raise ArgumentError
  end

  it "keeps track of instance variables" do
    @recipe.name.must_equal @name
    @recipe.url.must_equal @url
    @recipe.ingredients.must_equal @ingredients
  end

  it "tracks optionals" do
    options = {
      diet_labels: ["diet_labels"],
      health_labels: ["health_labels"]
    }
    recipe = Recipe.new(@name, @image, @url, @ingredients, options)

    recipe.diet_labels.must_equal options[:diet_labels]
    recipe.health_labels.must_equal options[:health_labels]
  end
end
