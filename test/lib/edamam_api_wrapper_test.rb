require 'test_helper'

describe "EdamamApiWrapper" do
  it "can get a search" do
    VCR.use_casset("yaml name") do
      result = EdamamApiWrapper.search(query)
    end
  end
end
