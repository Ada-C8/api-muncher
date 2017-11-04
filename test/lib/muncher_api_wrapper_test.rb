require 'test_helper'

describe MuncherApiWrapper do
  it "Can search recipes according to one word" do
    VCR.use_cassette("recipes") do
      result = MuncherApiWrapper.find_recipes("arroz", 1)
    end
  end
end
