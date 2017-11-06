require 'test_helper'

describe ApiMuncherWrapper do
  describe "get_recipes" do
    it "Can get a list of recipes" do
      VCR.use_cassette("recipes") do
        result = ApiMuncherWrapper.get_recipes("peach", 0)
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end #each
      end #use cassette
    end #get list
  end #get recipies

  it "Raises an error when there is no search term" do
    VCR.use_cassette("recipes") do
      food = "peach"
      from = 0
      proc {
        ApiMuncherWrapper.get_recipes(food)
      }.must_raise ArgumentError

      proc {
        ApiMuncherWrapper.get_recipes(from)
      }.must_raise ArgumentError
    end
  end # it

  describe "show_recipe" do
    it "Will show an individual recipe" do
      VCR.use_cassette("individual_recipe") do
        result = ApiMuncherWrapper.show_recipe("recipe_421df807e21c65c842ec62870604aed3")
        result.must_be_kind_of Recipe
      end
    end

    it "Raises an error when there is an invalid or blank URI" do
      VCR.use_cassette("individual_recipe") do
        proc {
          ApiMuncherWrapper.show_recipe()
        }.must_raise ArgumentError

        proc {
          ApiMuncherWrapper.get_recipes("123456")
        }.must_raise ArgumentError
      end
    end 

  end

end #all tests
