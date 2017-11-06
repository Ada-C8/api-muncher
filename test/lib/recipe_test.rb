require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  describe Recipe do
    it "can be created" do
      recipe = Recipe.new("name", "image", "uri")
      recipe.must_respond_to :name
      recipe.wont_be_nil
      recipe.name.must_equal "name"
      recipe.uri.must_equal "uri"
    end

    it "requires three parameters" do
      proc {
        Recipe.new
      }.must_raise ArgumentError

      proc {
        Recipe.new("name", "uri")
      }.must_raise ArgumentError
    end
  end
end
