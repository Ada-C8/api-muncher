require 'test_helper'
describe Recipe do

  describe "initialize" do
    it "Cannot be initialized without required parameters" do
      proc {
        Recipe.new
      }.must_raise ArgumentError

      proc {
        Recipe.new "title"
      }.must_raise ArgumentError
    end

    it "should initialize instance variables properly" do
      recipe = Recipe.new("uri", "title","image")
      recipe.title.must_equal "title"
      recipe.uri.must_equal "uri"
      recipe.image.must_equal "image"
    end

    it "responds to optional fields" do
      options = {
        "diet_labels": ["diet_labels"],
        "source": ["source"],
        "url": ["url"]
      }
      recipe = Recipe.new( ["Low-Fat"], [ "Vegan", "Vegetarian"], "Self", "http://www.self.com/challenge/2011/nutrition/recipe/dinners/soup-and-salad-combo")

      recipe.diet_labels.must_equal options["diet_labels"]
      recipe.source.must_equal options["source"]
      recipe.url.must_equal options["url"]
      recipe.ingredient_lines.must_equal options["ingredient_lines"]
    end
  end # end of initialize

  describe "id" do
    it "should return the id of a uri" do
      recipe = Recipe.new("http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289", "Title","image")
      recipe.id.must_equal "df05891dd71023b6271cb0fc67a88289"
    end
  end
end # end of Recipe
