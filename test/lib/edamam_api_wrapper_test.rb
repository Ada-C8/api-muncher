require 'test_helper'

describe EdamamApiWrapper do
  describe "list_recipes" do
    it "can get a list of recipes" do
      VCR.use_cassette("recipes") do
        result = EdamamApiWrapper.list_recipes("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "Raises an ApiError when the token is bad" do
      VCR.use_cassette("recipes") do
        proc {
          EdamamApiWrapper.list_recipes("chicken" + "&app_id=" + "bad_token")
        }
      end
    end
  end

  describe "show_recipe" do
    it "show recipe for cooresponding uri" do
      VCR.use_cassette("recipes") do
      end
    end

    it "Raises an error when wrong bad uri" do
      VCR.use_cassette("recipes") do
      end
    end
  end
end
