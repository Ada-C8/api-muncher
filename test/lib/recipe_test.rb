require 'test_helper'

describe "Recipe" do
  before do
    @name = "name"
    @id = "http//#hello"
    @image = "image"
    @url = "url"
    @ingredients = ["ingredients"]
    @recipe = Recipe.new(@name, @id, @image, @url, @ingredients)
  end

  describe "initialize" do
    it "can be instantiated" do
      @recipe.must_be_kind_of Recipe
    end

    it "Requires a name, id, image, url, and ingredients" do
      proc {
        Recipe.new()
      }.must_raise ArgumentError

      proc {
        Recipe.new("name", "image", "url")
      }.must_raise ArgumentError
    end

    it "maintains instance variables" do
      @recipe.name.must_equal @name
      @recipe.url.must_equal @url
      @recipe.ingredients.must_equal @ingredients
    end

    it "tracks optionals - diet and health" do
      options = {
        diet: ["diet_labels"],
        health: ["health_labels"]
      }
      recipe = Recipe.new(@name, @id, @image, @url, @ingredients, options)

      recipe.diet.must_equal options[:diet]
      recipe.health.must_equal options[:health]
    end
  end

  describe "creates an id" do
    it "works" do
      uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_c4a3b26a3e6d705817ead5b3b59796ef"
      recipe_1 = Recipe.new(@name, uri, @image, @url, @ingredients)

      recipe_1.id.must_equal "http://www.edamam.com/ontologies/edamam.owl%23recipe_c4a3b26a3e6d705817ead5b3b59796ef"
    end
  end
end
