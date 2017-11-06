require 'test_helper'
require 'awesome_print'

describe EdamamApiWrapper do

  it "can return a list of recipes for one query" do
    VCR.use_cassette("recipes") do

      recipes = EdamamApiWrapper.search("chicken")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "can return a list of recipes for two or more queries" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.search("potato butter")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0

      recipes = EdamamApiWrapper.search("orange banana strawberry")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0

    end
  end

  it "can take in an individual recipe's id (uri) as a query" do
    VCR.use_cassette("uri_search") do
      recipe = EdamamApiWrapper.search("f43ebb87d1f60273f31efa47e04b728c")
      recipe.must_be_instance_of Array
      recipe.length.must_equal 1
      recipe[0].must_be_instance_of Recipe
    end
  end

  it "Will return [] for a broken request" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.search("alksfjkasjfaskjdfldajhflaksjhdfksjh")
      recipes.must_be_instance_of Array
      recipes.must_equal []

      EdamamApiWrapper.search("").must_be_instance_of Array
    end
  end

  it "Will not break if invalid API tokens are passed" do
    VCR.use_cassette("invalid_API_key") do
      recipes = EdamamApiWrapper.search("chicken", "poop", "poop")
      recipes.must_be_instance_of Array
      recipes.must_equal []
    end
  end


end
