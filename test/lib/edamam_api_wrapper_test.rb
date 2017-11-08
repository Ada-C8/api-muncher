require 'test_helper'

describe EdamamApiWrapper do
    describe "list_recipes" do

      it "Can list a group of recipes" do

        VCR.use_cassette("recipes") do
          recipes = EdamamApiWrapper.list_recipes("apple")
          recipes.must_be_instance_of Array

          recipes.each do |recipe|
            recipe.must_be_instance_of Recipe
          end
        end
      end


      it "Will return [] for a broken request" do
        VCR.use_cassette("recipes") do
          recipes = EdamamApiWrapper.list_recipes(" ")
          recipes.must_be_instance_of Array
          recipes.must_equal []
        end
      end

  end

  describe "show_recipe" do

    it "Can show a requested recipe" do
      VCR.use_cassette("recipes") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        recipe = EdamamApiWrapper.show_recipe(uri)
        recipe.must_be_instance_of Recipe
      end
    end
  end
end
