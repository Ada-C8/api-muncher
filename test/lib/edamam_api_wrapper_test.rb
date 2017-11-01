require 'test_helper'
require 'awesome_print'

describe EdamamApiWrapper do

  it "can return a list of recipes for one query" do
    VCR.use_cassette("recipes") do

      recipes = EdamamApiWrapper.search_recipes("chicken")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "can return a lis of recipes for two or more queries" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.search_recipes("potato butter")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0

      recipes = EdamamApiWrapper.search_recipes("orange banana strawberry")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0

    end
  end

  it "Will return [] for a broken request" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.search_recipes("alksfjkasjfaskjdfldajhflaksjhdfksjh")
      recipes.must_be_instance_of Array
      recipes.must_equal []
    end
  end

  it "Will not break if invalid API tokens are passed" do
    VCR.use_cassette("invalid_API_key") do
      recipes = EdamamApiWrapper.search_recipes("chicken", "poop", "poop")
      recipes.must_be_instance_of Array
      recipes.must_equal []
    end
  end


end
