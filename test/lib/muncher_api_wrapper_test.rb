require 'test_helper'

describe MuncherApiWrapper do
  describe "find_recipes" do

    it "Can search recipes according to one word" do
      VCR.use_cassette("recipes") do
        result = MuncherApiWrapper.find_recipes("arroz", 1)
        result.must_be_kind_of Array
        result[0].each do |recipe|
          recipe.must_be_kind_of Recipe
        end
        result[0].length.must_equal 10
      end
    end

    it "Raises an error when token is bad" do
      VCR.use_cassette("recipes") do
        proc {
          MuncherApiWrapper.find_recipes("arroz", 1, "bad_id", "bad_token")
        }.must_raise MuncherApiWrapper::ApiError
      end
    end

    it "Can returns the amount of search found" do
      VCR.use_cassette("recipes") do
        result = MuncherApiWrapper.find_recipes("arroz", 1)
        result[1].must_be_kind_of Integer
      end
    end

    it "returns empty array  when there is not hits" do
      VCR.use_cassette("recipes") do
        result = MuncherApiWrapper.find_recipes("qw", 1)
        result[0].must_be_kind_of Array
        result[0].must_equal []
      end
    end

  end

  describe "find_recipes" do
    it "can get one recipe" do
      VCR.use_cassette("one_recipe") do
        uri = "6893cc673c96d3f26910052de21f2d89"
        result = MuncherApiWrapper.one_recipe(uri)
        result.must_be_kind_of Recipe
      end
    end


    it "returns empty array  when there is not hits" do
      VCR.use_cassette("one_recipe") do
        uri = "6893cc673c96d3f26910052d"
        MuncherApiWrapper.one_recipe(uri).must_equal []
      end
    end
  end

end
