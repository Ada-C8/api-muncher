require 'test_helper'

describe Recipe do

    before do
      data = {
        "uri": "http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289",
        "title": "Soup And Salad",
        "image": "https://www.edamam.com/web-img/f5a/f5ae3dd833b389dda006730bfa7e8f3b.jpg",
        "diet_labels": "Low-Fat",
        "source": "Self",
        "url": "http://www.self.com/challenge/2011/nutrition/recipe/dinners/soup-and-salad-combo",
        "ingredient_lines": ["1 cup black bean soup"]
      }

      @recipe = Recipe.new(
        data[:uri],
        data[:title],
        data[:image],
        options = {
          diet_labels: data[:diet_labels],
          source: data[:source],
          url: data[:url],
          ingredient_lines: data[:ingredient_lines]
        }
      )

    end

  describe "initialize" do

    it "Cannot be initialized without required parameters" do
      proc {
        Recipe.new
      }.must_raise ArgumentError

      proc {
        Recipe.new "title"
      }.must_raise ArgumentError
    end


    it "should initialize instance variables and optionals properly" do
      @recipe.must_be_kind_of Recipe

      @recipe.uri.must_equal "http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289"
      @recipe.title.must_equal "Soup And Salad"
      @recipe.image.must_equal "https://www.edamam.com/web-img/f5a/f5ae3dd833b389dda006730bfa7e8f3b.jpg"
      @recipe.diet_labels.must_equal "Low-Fat"
      @recipe.source.must_equal "Self"
      @recipe.url.must_equal "http://www.self.com/challenge/2011/nutrition/recipe/dinners/soup-and-salad-combo"
      @recipe.ingredient_lines.must_be_kind_of Array
    end
  end # end of initialize

  describe "id" do
    it "should return the id of a uri" do
      recipe = Recipe.new("http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289", "Title","image")
      recipe.id.must_equal "df05891dd71023b6271cb0fc67a88289"
    end
  end
end # end of Recipe
