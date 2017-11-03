require 'test_helper'

describe EdamamApiWrapper do
  before do
    @search_string = "chicken"
    @bogus_search_str = "1234567%$!"
  end

  describe "self#list_recipes" do
    it "Can list a group of channels" do
    end
    it "Can list a group of channels" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes(@search_string)
        recipes.must_be_instance_of Array

        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "Will return [] for a broken request" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes(@bogus_search_str)
        recipes.must_be_instance_of Array
        recipes.must_equal []
      end
    end

    it "Will return [] for invalid app_id and app_key" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes(@search_string, "wrong_app_id", "wrong_app_key")
        recipes.must_be_instance_of Array
        recipes.must_equal []
      end
    end
  end
end
