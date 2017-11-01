require 'test_helper'

describe RecipeApiWrapper do

  describe "#search" do
    #success case
    it "Can acquire a list of recipes" do
      VCR.use_cassette("recipes") do
        food = "cheese"
        from = "10"
        result = RecipeApiWrapper.search(food, from)

        result.must_be_kind_of Array

        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end #result.each do

        result.length.must_be :>, 0
      end #VCR do
    end #it

    #error case
    it "Raises an error when two arguments are not passed" do
      VCR.use_cassette("recipes") do
        food = "chicken"
        from = '0'
        proc {
          RecipeApiWrapper.search(food)
        }.must_raise ArgumentError

        proc {
          RecipeApiWrapper.search(from)
        }.must_raise ArgumentError
      end
    end # it

    it "Raises an error when the app id is incorrect" do
      VCR.use_cassette("recipes") do
        food = "cheese"
        from = "0"
        app_id = "bogus"

        proc {
          RecipeApiWrapper.search(food, from, app_id)
        }.must_raise RecipeApiWrapper::ApiError
      end
    end # it


  end # describe search

  desribe "#find" do
    #success -- it is able to find the recipe -- numst return instance of recipe


    #failure -- it is not able to find recipe (wrong id) -- must return nil



  end




end # describe recipeapiwrapper
