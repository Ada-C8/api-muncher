require 'test_helper'

describe "Recipe Class" do
  before do
    @recipe = Recipe.new("name", "original_url", "ingredients", "dietLabels")
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
      }

    end

    it "Tracks required parameters: name, original_url, ingredients, dietLabels" do
      @recipe.name.must_equal "name"
      @recipe.original_url.must_equal "original_url"
      @recipe.ingredientsLine.must_equal "ingredients"
      @recipe.dietLabels.must_equal "dietLabels"
    end


  end
end
