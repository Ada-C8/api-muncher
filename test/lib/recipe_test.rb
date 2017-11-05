require 'test_helper'

describe "Recipe Class" do
  before do
    options = {
      image: "http::image"
    }

    @recipe = Recipe.new("name", "original_url", "ingredients", "dietLabels", options)
  end
  describe "initialize" do
    it "Can be instanciated with name, original_url, ingredients, dietLabels" do
      @recipe.must_be_instance_of Recipe
    end

    it "Raises ArgumentError if name, original_url, ingredients, dietLabels is either nil or empty string" do
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

    it "Tracks required parameters: name, original_url, ingredients, dietLabels" do
      @recipe.name.must_equal "name"
      @recipe.original_url.must_equal "original_url"
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
