require 'test_helper'

describe "EdamamApiWrapper" do
  it "can get a search" do
    VCR.use_cassette("search") do
      result = EdamamApiWrapper.search("chicken")
    end
  end
end
