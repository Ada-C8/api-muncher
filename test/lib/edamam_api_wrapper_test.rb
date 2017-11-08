require 'test_helper'

describe EdamamApiWrapper do

  describe "self.list_recipes" do
    it "Can get recipes with a search word." do
      VCR.use_cassette("recipes") do
        search = "cheese"
        recipes = EdamamApiWrapper.list_recipes(search)
        recipes.must_be_instance_of Array
      end
    end

    it "Will return empty array if no search word is provided." do
      VCR.use_cassette("recipes") do
        search = ""
        recipes = EdamamApiWrapper.list_recipes(search)
        recipes.must_equal []
      end
    end

    it "Will return an empty array if gibberish is provided." do
      VCR.use_cassette("recipes") do
        search = "cjldksjafajfgjhakgj"
        recipes = EdamamApiWrapper.list_recipes(search)
        recipes.must_equal []
      end
    end
  end

  describe "self.show_recipe" do
    it "Can retrieve a recipe." do
      VCR.use_cassette("recipes") do
        good_uri = "c23d4d64e02318eef70940c6643353ad"
        recipe = EdamamApiWrapper.show_recipe(good_uri)
        recipe.title.must_equal "Pimento Cheese"
        recipe.wont_be_nil
      end
    end

    it "Returns nil for an invalid uri" do
      VCR.use_cassette('recipes') do
        invalid_uri = "notarealthing"
        recipe = EdamamApiWrapper.show_recipe(invalid_uri)
        recipe.must_be_nil
      end
    end
  end
end
