require 'test_helper'

describe "Recipe Class" do
  before do
    options = {
      image: "http::image"
    }

    @recipe = Recipe.new("name", "url", "ingredients", "dietLabels", options)
  end
  describe "initialize" do
    it "Can be instanciated with name, url, ingredients, dietLabels" do
      @recipe.must_be_instance_of Recipe
    end

    it "Raises ArgumentError if name, url, ingredients, dietLabels is either nil or empty string" do
      proc {
        Recipe.new()
      }.must_raise ArgumentError

      proc {
        Recipe.new("")
      }.must_raise ArgumentError

      proc {
        Recipe.new("name")
      }.must_raise ArgumentError

    end

    it "Tracks required parameters: name, url, ingredients, dietLabels" do
      @recipe.name.must_equal "name"
      @recipe.url.must_equal "url"
      @recipe.ingredientsLine.must_equal "ingredients"
      @recipe.dietLabels.must_equal "dietLabels"
    end

    it "Tracks option parameters" do
      options = {
        image: "http::image"
      }

      @recipe.image.must_equal options[:image]
    end


  end
end
