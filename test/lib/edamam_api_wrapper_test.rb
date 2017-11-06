require 'test_helper'

describe EdamamApiWrapper do
  decribe "list_recipes" do
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
      keywords = "lemon poppy"
      number_of_recipes = EdamamApiWrapper.find_number_of_recipes(keywords)
      number_of_recipes.must_be_instance_of Integer
      recipes.count.must_be :>, 0
    end

    it "returns an 0 if there are no recipes" do
      keywords = "raclettesirachapoppy"
      number_of_recipes = EdamamApiWrapper.find_number_of_recipes(keywords)
      number_of_recipes.must_be_instance_of Integer
      recipes.count.must_equal 0
    end
  end

  describe "show_recipe" do
    params['id'] = "l#recipe_cc9460afce7beed8f828abc3221fb960"
    recipe = EdamamApiWrapper.show_recipe(params['id'])
    recipe.must_be_instance_of Recipe
    

  end
end
