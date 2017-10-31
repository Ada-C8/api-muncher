require 'test_helper'

describe "EdamamApiWrapper" do
  describe "search" do
    it "can get a search" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "returns an empty array if no items are found" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("lkuguyfyrd")
        result.must_be_kind_of Array
        result.empty?.must_equal true
      end
    end
  end

  describe "find_recipe" do
    before do
      @uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f77adf7b01a1f61cbb2fa0d6b290af60"
    end
    it "gets one instance of recipe" do
      VCR.use_cassette("find_recipe") do
        result = EdamamApiWrapper.find_recipe(@uri)
        result.must_be_kind_of Recipe
        result.id.must_equal @uri
      end
    end

    # it "returns empty string if uri is bad" do
    #   VCR.use_cassette("find_recipe") do
    #     result = EdamamApiWrapper.find_recipe(@uri)
    #     result.must_be_kind_of Recipe
    #     result.id.must_equal @uri
    #   end
    # end
  end
end


# describe SlackApiWrapper do
#   describe "list_channels" do
#     it "Can get a list of channels" do
#       VCR.use_cassette("channels") do
#         result = SlackApiWrapper.list_channels
#         result.must_be_kind_of Array
#         result.length.must_be :>, 0
#         result.each do |chan|
#           chan.must_be_kind_of Channel
#         end
#       end
#     end
#
#     it "Raises an ApiError when the token is bad" do
#       VCR.use_cassette("channels") do
#         proc {
#           SlackApiWrapper.list_channels("bogus_token")
#         }.must_raise SlackApiWrapper::ApiError
#       end
#     end
#   end
#
#   describe "send_msg" do
#     it "Can send a message to a channel" do
#       VCR.use_cassette("channels") do
#         result = SlackApiWrapper.send_msg("test-api-channel", "test message")
#         result.must_equal true
#       end
#     end
#
#     it "Raises an ApiError if the channel D.N.E." do
#       VCR.use_cassette("channels") do
#         proc {
#           SlackApiWrapper.send_msg("channel-that-doesnt-exist", "test message")
#         }.must_raise SlackApiWrapper::ApiError
#       end
#     end
#
#     it "Does something if the message is blank" do
#       VCR.use_cassette("channels") do
#         proc {
#           SlackApiWrapper.send_msg("test-api-channel", "")
#         }.must_raise SlackApiWrapper::ApiError
#       end
#     end
#   end
# end
