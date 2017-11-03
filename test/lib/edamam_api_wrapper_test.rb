require 'test_helper'

describe EdamamApiWrapper do
  it "can receive a list of recipes as Recipe objects (for a single word search term)" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes("lemon", 0, 9)
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "can receive a list of recipes as Recipe objects (for a mulitple word search term)" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes("lemon chicken artichoke", 0, 9)
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "will return an empty array for a bogus request" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes("jklmnopqrstuv", 0, 9)
      recipes.must_be_instance_of Array
      recipes.count.must_equal 0
    end
  end



end
