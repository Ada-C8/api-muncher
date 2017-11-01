require 'test_helper'

describe EdamamApiWrapper do
    it "can list the found recipes" do
      search = "chicken"
      VCR.use_cassette("hits") do
      recipes = EdamamApiWrapper.list_recipes(search)
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end
end
