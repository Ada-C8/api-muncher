require 'test_helper'

describe MuncherApiWrapper do
  it "can get a list of recipes" do
    VCR.use_cassette("searches") do
      result = MuncherApiWrapper.search("term")
    end
  end
end
