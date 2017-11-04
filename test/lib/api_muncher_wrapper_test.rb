require 'test_helper'

describe ApiMuncherWrapper do

  describe "search" do
    it "can search recipes" do
      VCR.use_cassette("recipes") do
        recipes = ApiMuncherWrapper.search_recipes("coffee",options={option:{}})
        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "can search recipes will multiple words" do
      VCR.use_cassette("recipes") do
        recipes = ApiMuncherWrapper.search_recipes("quinoa salad",options={option:{}})
        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end


    it "will return [] for a broken request" do
      VCR.use_cassette("recipes") do
        recipes = ApiMuncherWrapper.search_recipes("",options={option:{}})
        recipes.must_be_instance_of Array
        recipes.must_equal []
      end
    end
  end

  describe "find" do
    it "will find a recipe" do
      VCR.use_cassette("recipes") do
        uri = "bcbbb3cd875fa61b5601231a709812a6"
        recipe = ApiMuncherWrapper.find_recipes(uri)
        recipe.must_be_instance_of Recipe
      end
    end

    it "will return nil if bogus" do
      VCR.use_cassette("recipes") do
        uri = "bogus"
        recipe = ApiMuncherWrapper.find_recipes(uri)
        recipe.must_be_nil
      end
    end
  end
end
