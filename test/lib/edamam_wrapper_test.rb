require 'test_helper'

describe EdamamWrapper do
  describe 'list_recipes' do
    it 'can get a list of recipes' do
      VCR.use_cassette("recipes") do
        item = "egg"
        from = "10"
        result = EdamamWrapper.list_recipes(item, from)
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |r|
          r.must_be_kind_of Recipe
        end
      end
    end

    it "Does something when the api is bad" do
      begin # something which might raise an exception
        origin_api = EdamamWrapper::KEY
        EdamamWrapper::KEY = "bogus_data"

        VCR.use_cassette("recipes") do
          item = "egg"
          from = "0"
          proc {
            EdamamWrapper.list_recipes(item, from)
          }.must_raise EdamamWrapper::ApiError
        end
      ensure # ensure this code always runs; does not change final value of block
        EdamamWrapper::KEY = origin_api
      end
    end
  end


  describe "find_recipe" do
    it "returns a recipe when given a valid uri" do
      VCR.use_cassette("wrapper_test") do
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"

        recipe = EdamamWrapper.find_recipe(uri)

        recipe.must_be_kind_of Recipe
      end
    end

    # it "does not return a recipe with a bogus uri" do
    #   VCR.use_cassette("wrapper_test") do
    #     uri = "bogus_data"
    #     proc {
    #       EdamamWrapper.find_recipe(uri)
    #     }.must_raise EdamamWrapper::ApiError
    #   end
    # end
  end
end
