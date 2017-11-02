require 'test_helper'

describe EdamamApiWrapper do
  describe "search" do
    it "can return an array of recipe objects" do
      VCR.use_cassette("search") do
        recipes = EdamamApiWrapper.search("chocolate")

        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |r|
          r.must_be_instance_of Recipe
        end
      end
    end

    it "will return an empty array for a search that returns no results" do
      VCR.use_cassette("search") do
        recipes = EdamamApiWrapper.search("13,5fo")

        recipes.must_equal []
      end

    end

    it "will return return an empty array if it lacks an app key or an app id" do
      VCR.use_cassette("search") do
        recipes = EdamamApiWrapper.search("chocolate", "", "")

        recipes.must_equal []
      end

    end

    it "will return an empty array if given a bogus id or key" do
      VCR.use_cassette("search") do
        recipes = EdamamApiWrapper.search("chocolate", "Bogus")

        recipes.must_equal []

        recipes = EdamamApiWrapper.search("chocolate", nil, "Bogus")
        recipes.must_equal []
      end
    end
  end


  describe "search_item" do
    let(:uri) { URI.encode( "http://www.edamam.com/ontologies/edamam.owl#recipe_8643e0c3105bcb0d3c3a417308a09c03") }

    it "will return a recipe object" do
      VCR.use_cassette("search_item") do
        recipe = EdamamApiWrapper.item_search(uri)
        recipe.must_be_instance_of Recipe
      end

    end

    it "will return nil for a search that doesn't exit" do
      VCR.use_cassette("search_item") do
        recipe = EdamamApiWrapper.item_search("www.google.com")
        recipe.must_equal nil
      end
    end

    it "will return nil for an empty search string" do
      VCR.use_cassette("search_item") do
        recipe = EdamamApiWrapper.item_search("")
        recipe.must_equal nil
      end
    end

    it "will return nil if the app_key is wrong" do
      VCR.use_cassette("search_item") do
        recipe = EdamamApiWrapper.item_search(uri, nil, "bogus")
      end
    end

    it "will return nil if the app_id is wrong" do
      VCR.use_cassette("search_item") do
        recipe = EdamamApiWrapper.item_search(uri, "Bogus", nil)
      end

    end

  end



end
