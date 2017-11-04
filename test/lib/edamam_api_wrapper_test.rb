require 'test_helper'

describe EdamamApiWrapper do

  describe "self.list_recipes" do
    it "Can get recipes with a search word." do
      VCR.use_cassette("recipes") do
        search = "cheese"
        recipes = EdamamApiWrapper.list_recipes(search, 0)

        recipes.count.must_equal 10
        recipes.must_be_instance_of Array
        recipes.each { |recipe| recipe.must_be_instance_of Recipe }
      end
    end
  end

    it "Will return empty array if no search word is provided." do
      VCR.use_cassette("recipes") do
        search = ""
        recipes = EdamamApiWrapper.list_recipes(search, 0 )
        recipes.must_equal []
      end
    end

  describe "self.show_recipe" do
    it "Can retrieve a recipe." do
      VCR.use_cassette("recipes") do
        recipe =
        "https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_c23d4d64e02318eef70940c6643353ad"
        recipe

      end
    end
  end
end
