require 'test_helper'

describe EdamamApiWrapper do
  it "Can list a group of recipes" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes("apple", "")
      recipes.must_be_instance_of Array
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recette
      end
    end
  end
  it "returns false for a broken request" do
    VCR.use_cassette("recipes") do
      recipes = EdamamApiWrapper.list_recipes("apple", "", "BOGUS", "SUPERBOGUUUUS")
      recipes.must_equal false
    end
  end
  # it "Can find a particular recipe" do
  #   VCR.use_cassette("recipes") do
  #     recipe = EdamamApiWrapper.find_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2")
  #     recipe.must_be_instance_of Recette
  #     recipe.title.must_equal "Teriyaki Chicken"
  #   end
  # end
  # it "returns false for a broken request" do
  #   VCR.use_cassette("recipes") do
  #     recipe = EdamamApiWrapper.find_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2", "BOGUS", "SUPERBOGUUUUS")
  #     recipe.must_equal false
  #   end
  # end
end
