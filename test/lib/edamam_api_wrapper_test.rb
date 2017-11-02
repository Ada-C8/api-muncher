require 'test_helper'

describe EdamamApiWrapper do

  describe "self.query" do
    #TODO
    # not getting any results back (getting empty array)
    it "can do a query" do
      VCR.use_cassette("query") do
        query = "tofu"
        results = EdamamApiWrapper.query(query)
        results.must_be_instance_of Array
        results.length.must_be :>, 0
        results.each do |result|
          result.must_be_instance_of Recipe
        end
      end
    end

    it "will redirect to home page if no search results" do
      VCR.use_cassette("query") do
        query = ""
        results = EdamamApiWrapper.query(query)

        results.must_be_instance_of Array
        results.must_equal []
      end
    end
  end # end of self.query

  describe "self.find_recipe" do
    it "find_recipe will return a specific recipe object" do
      VCR.use_cassette("find_recipe") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        uri = URI.escape(uri)
        recipe = EdamamApiWrapper.find_recipe(uri)
        recipe.must_be_instance_of Recipe
        recipe.name.must_equal "Teriyaki Chicken"
      end
    end

    it "recipe will be empty array if individual recipe not found" do
      VCR.use_cassette("find_recipe") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        recipe = EdamamApiWrapper.find_recipe(uri)
        recipe.must_equal []
      end
    end
  end # end of find_recipe
end # end of EdamamApiWrapper
