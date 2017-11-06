require 'test_helper'

describe EdamamApiWrapper do
  describe 'search_recipes' do
    it "can search for a list of recipes" do
      VCR.use_cassette('recipe_list') do
        list = EdamamApiWrapper.search_recipes("pineapple")
        list.must_be_instance_of Array
        list.length.must_be :>, 0
      end
    end

    it "search returns recipe objects" do
      VCR.use_cassette('recipe_list') do
        list = EdamamApiWrapper.search_recipes("pineapple")
        list.each do |recipe|
          recipe.must_be_instance_of Recipe
        end
      end
    end

    it "returns an empty array if no results" do
      VCR.use_cassette('recipe_list') do
        list = EdamamApiWrapper.search_recipes('sdjhfkj3jh4k')
        list.must_be_instance_of Array
        list.length.must_equal 0
      end
    end
  end

  describe 'recipe_details' do
    it "returns a specific recipe with a valid uri" do
      VCR.use_cassette('recipe_details') do
        valid_uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_637913ec61d9da69eb451818c3293df2"
        recipe = EdamamApiWrapper.recipe_details(valid_uri)
        recipe.wont_be_nil
        recipe.label.must_equal 'Dijon And Tarragon Grilled Chicken'
      end
    end

    it "returns nil for a bogus uri" do
      VCR.use_cassette('recipe_details') do
        bogus_uri = "http://www.edamam.com/ontologies/edamam.owl#SUPERBOGUS"
        recipe = EdamamApiWrapper.recipe_details(bogus_uri)
        recipe.must_be_nil
      end
    end
  end

  describe 'food_options' do
    it "returns an array of arrays" do
      list = EdamamApiWrapper.food_options
      list.must_be_instance_of Array
      list.each_index do |i|
        list[i].must_be_instance_of Array
      end
    end
  end
end
