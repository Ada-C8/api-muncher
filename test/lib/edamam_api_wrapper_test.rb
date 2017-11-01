require "test_helper"
require "httparty"
describe EdamamApiWrapper do
  describe "list_recipes" do
    it "can generate a list of recipes for a search term" do
      VCR.use_cassette("yogurt") do
        result = EdamamApiWrapper.list_recipes("yogurt")
        result.length.must_be :>, 0
        result.must_be_kind_of Array
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "Raises and ApiError when the app_id is bogus" do
      VCR.use_cassette("smoothie_recipes") do
        proc {
          EdamamApiWrapper.list_recipes("smoothie","bogus app id")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end
end
