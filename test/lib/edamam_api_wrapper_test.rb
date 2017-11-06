require 'test_helper'

describe EdamamApiWrapper do

  it "can list results from a query" do
    VCR.use_cassette("recipe_query") do
      recipe_results = EdamamApiWrapper.search("chocolate")
      recipe_results.must_be_instance_of Array
      recipe_results.length.must_be :>, 0
      recipe_results.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "will return [] for a query returning no results" do
    VCR.use_cassette("recipe_query") do
      recipe_results = EdamamApiWrapper.search("999")
      recipe_results.must_be_instance_of Array
      recipe_results.must_equal []
    end
  end

  it "can view a individual recipe" do
    VCR.use_cassette("view_recipe") do
      recipe = EdamamApiWrapper.view_recipe("http://www.edamam.com/ontologies/edamam.owl#recipe_8643e0c3105bcb0d3c3a417308a09c03")
      recipe.must_be_instance_of Array
    end
  end

  it "will return [] for a bogus uri" do
    VCR.use_cassette("view_recipe") do
      recipe = EdamamApiWrapper.view_recipe("http://www.edamam.com/ontologies/edamam.owl#not_a_real_recipe")
      recipe.must_equal []
    end
  end

end
