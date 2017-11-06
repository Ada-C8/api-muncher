require 'test_helper'

describe MuncherApiWrapper do
  describe "find_recipes" do

    it "Can search recipes according to one word" do
      VCR.use_cassette("recipes") do
        result = MuncherApiWrapper.find_recipes("arroz", 1)
        result.must_be_kind_of Array
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
        result.length.must_equal 10
      end
    end

    # it "Fails when there is not internet" do
    #   VCR.use_cassette("no_network_connection") do
    #     result = MuncherApiWrapper.find_recipes('queso', 1)
    #   end
    # end

    it "Raises an error when token is bad" do
      VCR.use_cassette("recipes") do
        proc {
          MuncherApiWrapper.find_recipes("arroz", 1, "bad_id", "bad_token")
        }.must_raise MuncherApiWrapper::ApiError
      end
    end

    #TODO make a test when the page is invalid like ("arroz", 0), I have that information in the yml
  end

  describe "find_recipes" do
    it "can show one recipe" do
      VCR.use_cassette("one_recipe") do
        uri = " 54d578f9ae75221df8cdd217f9ca964c"
        result = MuncherApiWrapper.one_recipe(uri)
        result.must_be_kind_of Recipe
      end
    end
  end

end


# VCR.use_cassette("find_recipe") do
#         valid_uri = "637913ec61d9da69eb451818c3293df2"
#         result = EdamamApiWrapper.find_recipe(valid_uri)
#         result.must_be_kind_of Recipe
