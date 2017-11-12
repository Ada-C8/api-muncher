require "test_helper"

describe EdamamApiWrapper do
  before do
    @uri_good = "637913ec61d9da69eb451818c3293df2"
    @uri_bad = "637913ec61d9da69eb451818"
  end

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

    it "Raises an ApiError when the app_id is bogus" do
      VCR.use_cassette("smoothie_recipes") do
        proc {
          EdamamApiWrapper.list_recipes("smoothie","bogus app id")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

    it "Raises an ApiError when the search term is bogus either empty or returns no recipes" do
      VCR.use_cassette("smoothie_recipes") do
        proc {
          EdamamApiWrapper.list_recipes("")
        }.must_raise EdamamApiWrapper::ApiError
        proc {
          EdamamApiWrapper.list_recipes("asdf909834jjklksr098g09rjlkj45-908djgdlfkjgl")
        }.must_raise EdamamApiWrapper::ApiError
      end
    end

    # TODO: do we need a test for when no recipes are returned?
  end

  describe "show_recipe" do
    it "return a single recipe" do
      VCR.use_cassette("recipe_show") do
        result = EdamamApiWrapper.show_recipe(@uri_good)
        result.must_be_kind_of Recipe
      end
    end

    it "Raises Api Error when the uri is bad and you don't get any data back from api" do
      VCR.use_cassette("recipe_show") do
        proc {
          EdamamApiWrapper.show_recipe(@uri_bad)
        }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end
end
