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

    it "Raises an error when token is bad" do
      VCR.use_cassette("recipes") do
        proc {
          MuncherApiWrapper.find_recipes("arroz", 1, "bad_id", "bad_token")
        }.must_raise MuncherApiWrapper::ApiError
      end
    end

    it "Raises an error when page is bad" do
      VCR.use_cassette("recipes") do
        proc {
          MuncherApiWrapper.find_recipes("arroz", 0)
        }.must_raise MuncherApiWrapper::ApiError
      end
    end

    #TODO make a test when the page is invalid like ("arroz", 0), I have that information in the yml
  end

  describe "find_recipes" do
    it "can show one recipe" do
      VCR.use_cassette("one_recipe") do
        # uri = "54d578f9ae75221df8cdd217f9ca964c"
        uri = "6893cc673c96d3f26910052de21f2d89"
        result = MuncherApiWrapper.one_recipe(uri)
        result.must_be_kind_of Recipe
      end
    end
    # it "raises an error recipe with given id doesn't exist" do
    #   VCR.use_cassette("bad_id") do
    #     uri = "54d578f9ae75221df8cdd217"
    #     proc {
    #       MuncherApiWrapper.one_recipe(uri)
    #     }.must_raise MuncherApiWrapper::ApiError
    #   end
    # end
  end

end
