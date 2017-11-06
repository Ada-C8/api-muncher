require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'

describe Recipe do

  it "requires one parameter to be created" do
    #error if no keyword is passed to it
    proc {
      Recipe.new
    }.must_raise ArgumentError
  end

  it "can be created" do
    @recipes_hash = {
      "uri" => "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2",
      "label" => "Teriyaki Chicken",
      "image" => "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg",
      "source" => "David Lebovitz",
      "url" => "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/",
      "shareAs" => "http://www.edamam.com/recipe/teriyaki-chicken-7bf4a371c6884d809682a72808da7dc2/chicken",
      "yield" => 6.0,
      "dietLabels" => [ "Low-Carb" ],
      "healthLabels" => [ "Sugar-Conscious", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free" ],
      "cautions" => [ ],
      "ingredientLines" => [ "1/2 cup (125ml) mirin", "1/2 cup (125ml) soy sauce", "One 2-inch (5cm) piece of fresh ginger, peeled and grated", "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)" ]
    }
      a_recipe= Recipe.new(@recipes_hash)
      a_recipe.must_respond_to :uri
      a_recipe.must_respond_to :label
      a_recipe.must_respond_to :image
      a_recipe.must_respond_to :source
      a_recipe.must_respond_to :url
      a_recipe.must_respond_to :dietLabels
      a_recipe.must_respond_to :healthLabels
      a_recipe.must_respond_to :ingredientLines
      a_recipe.wont_be_nil
      a_recipe.label.must_equal "Teriyaki Chicken"
      a_recipe.uri.must_equal URI.escape("http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2")
  end

  describe "find_recipe_id" do
    it "returns a recipe id" do
      @recipes_hash = {
        "uri" => "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2",
        "label" => "Teriyaki Chicken",
        "image" => "https://www.edamam.com/web-img/262/262b4353ca25074178ead2a07cdf7dc1.jpg",
        "source" => "David Lebovitz",
        "url" => "http://www.davidlebovitz.com/2012/12/chicken-teriyaki-recipe-japanese-farm-food/",
        "shareAs" => "http://www.edamam.com/recipe/teriyaki-chicken-7bf4a371c6884d809682a72808da7dc2/chicken",
        "yield" => 6.0,
        "dietLabels" => [ "Low-Carb" ],
        "healthLabels" => [ "Sugar-Conscious", "Peanut-Free", "Tree-Nut-Free", "Alcohol-Free" ],
        "cautions" => [ ],
        "ingredientLines" => [ "1/2 cup (125ml) mirin", "1/2 cup (125ml) soy sauce", "One 2-inch (5cm) piece of fresh ginger, peeled and grated", "2-pounds (900g) boneless chicken thighs (4-8 thighs, depending on size)" ]
      }
      a_recipe= Recipe.new(@recipes_hash)
      a_recipe.find_recipe_id.must_be_instance_of String
    end
  end

end
