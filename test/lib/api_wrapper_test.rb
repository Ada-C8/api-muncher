require 'test_helper'

describe ApiWrapper do
  describe "list_recipes" do
    it "get list of recipes" do
      VCR.use_cassette("recipes") do
        result = ApiWrapper.list_recipes("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
      end
    end
  end
end

# it "Can get a list of channels" do
#       VCR.use_cassette("channels") do
#         result = SlackApiWrapper.list_channels
#         result.must_be_kind_of Array
#         result.length.must_be :>, 0
#         result.each do |chan|
#           chan.must_be_kind_of Channel
#         end
#       end
#     end
