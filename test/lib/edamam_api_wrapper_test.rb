require 'test_helper'

describe EdamamApiWrapper do


  describe "search" do
    it "receives a valid response for a search" do
      VCR.use_cassette("recipes") do
        response = EdamamApiWrapper.search("fish")

        response.length.must_be :>, 0
        response.must_be_kind_of HTTParty::Response
      end
    end
  end
end
#
#   #   it "Raises an ApiError when the token is bad" do
#   #     VCR.use_cassette("channels") do
#   #       proc {
#   #         SlackApiWrapper.list_channels("bogus_token")
#   #       }.must_raise SlackApiWrapper::ApiError
#   #     end
#   #   end
#   # end
#   #
#   # describe "send_msg" do
#   #   it "Can send a message to a channel" do
#   #     VCR.use_cassette("channels") do
#   #       result = SlackApiWrapper.send_msg("test-api-channel", "test message")
#   #       result.must_equal true
#   #     end
#   #   end
#   #
#   #   it "Raises an ApiError if the channel D.N.E." do
#   #     VCR.use_cassette("channels") do
#   #       proc {
#   #         SlackApiWrapper.send_msg("channel-that-doesnt-exist", "test message")
#   #       }.must_raise SlackApiWrapper::ApiError
#   #     end
#   #   end
#   #
#   #   it "Does something if the message is blank" do
#   #     VCR.use_cassette("channels") do
#   #       proc {
#   #         SlackApiWrapper.send_msg("test-api-channel", "")
#   #       }.must_raise SlackApiWrapper::ApiError
#   #     end
#   #   end
#   end
# end
