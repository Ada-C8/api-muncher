require 'test_helper'

describe EdamamApiWrapper do
  describe "list_recipes" do
    it "can receive a list of recipes as Recipe objects (for a single word search term)" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("lemon", 0, 9)
        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "can receive a list of recipes as Recipe objects (for a mulitple word search term)" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("lemon chicken artichoke", 10, 19)
        recipes.must_be_instance_of Array
        recipes.length.must_be :>, 0
        recipes.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end


    it "will return an empty array for a bogus request" do
      VCR.use_cassette("recipes") do
        recipes = EdamamApiWrapper.list_recipes("jklmnopqrstuv", 0, 9)
        recipes.must_be_instance_of Array
        recipes.count.must_equal 0
      end
    end

  end

  describe "find_number_of_recipes" do
    it "returns an integer" do
      VCR.use_cassette("recipes") do
        keywords = "lemon%20poppy"
        number_of_recipes = EdamamApiWrapper.find_number_of_recipes(keywords)
        number_of_recipes.must_be_instance_of Integer
        number_of_recipes.must_be :>, 0
      end
    end

    it "returns an 0 if there are no recipes" do
      VCR.use_cassette("recipes") do
        keywords = "raclettesirachapoppy"
        number_of_recipes = EdamamApiWrapper.find_number_of_recipes(keywords)
        number_of_recipes.must_be_instance_of Integer
        number_of_recipes.must_equal 0
      end
    end
  end

  describe "show_recipe" do
    it "must return a recipe object" do
      VCR.use_cassette("recipes") do
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
        uri_id = a_recipe.find_recipe_id
        recipe_url = EdamamApiWrapper.show_recipe(uri_id)
        recipe_url.must_be_instance_of Recipe
      end
    end
  end
end
