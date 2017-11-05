require 'test_helper'

describe EdamamApiWrapper do
    it "can list the found recipes" do
      search_term = "chicken"
      VCR.use_cassette("hits") do
      recipes = EdamamApiWrapper.list_recipes(search_term)
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "will return an empty array for a broken request" do
    search_term = " "
    VCR.use_cassette("hits") do
      recipes = EdamamApiWrapper.list_recipes(search_term)

      recipes.must_be_instance_of Array
      recipes.must_equal []
    end
  end
end
