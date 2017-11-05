require 'test_helper'

describe MuncherApiWrapper do
  # it "can get a list of recipes" do
  #   VCR.use_cassette("searches") do
  #     result = MuncherApiWrapper.search("term")
  #   end
  # end
  #
  # it "returns an array of recipes" do
  #   VCR.use_cassette("searches") do
  #     result = MuncherApiWrapper.search("term")
  #     result.must_be_kind_of Array
  #     result.length.must_be :>, 0
  #     result.each do |recipe|
  #       recipe.must_be_kind_of Recipe
  #     end
  #   end
  # end

  it "does something when key is bad" do
    VCR.use_cassette("searches") do
      proc {
      result = MuncherApiWrapper.search("term", 0, "bogus_key")
    }.must_raise MuncherApiWrapper::ApiError
    end
  end


end
