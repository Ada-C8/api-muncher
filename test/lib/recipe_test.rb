require 'test_helper'

describe "Recipe" do
  before do
    @name = "name"
    @id = "http//#hello"
    @image = "image"
    @url = "url"
    @source = "source"
    @ingredients = ["ingredients"]
    @recipe = Recipe.new(@name, @id, @image, @url, @source, @ingredients)
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
      recipe = Recipe.new(@name, @id, @image, @url, @source, @ingredients, options)

      recipe.diet_labels.must_equal options[:diet_labels]
      recipe.health_labels.must_equal options[:health_labels]
    end
  end

  describe "create_id" do
    it "works" do
      uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_c4a3b26a3e6d705817ead5b3b59796ef"
      recipe_1 = Recipe.new(@name, uri, @image, @url, @source, @ingredients)

      recipe_1.id.must_equal "http://www.edamam.com/ontologies/edamam.owl%23recipe_c4a3b26a3e6d705817ead5b3b59796ef"
    end
  end
end
