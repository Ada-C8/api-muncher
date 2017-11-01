require 'test_helper'

describe EdamamApiWrapper do
  it "can receive a list of recipes" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.list_recipes
      channels.must_be_instance_of Array
      channels.length.must_be :>, 0
      channels.each do |channel|
        channel.must_be_instance_of Channel
      end
    end
  end

  it "will return an empty array for a broken request" do
    VCR.use_cassette("channels") do
      channels = SlackApiWrapper.list_channels("BOGUS")
      channels.must_be_instance_of Array
      channels.count.must_equal 0
    end
  end

  describe "send_msg" do
    it "can send a message to a channel" do
      VCR.use_cassette("send_msg") do
        response = SlackApiWrapper.send_msg "test-api-channel", "Julia - Test case"
        response["ok"].must_equal true

      end
    end

    it "cannot send a message to a bogus channel" do
      VCR.use_cassette("send_msg") do
        response = SlackApiWrapper.send_msg "test-api-channel-BOGUS", "Julia - Test case"
        response["ok"].must_equal false
        response["error"].must_equal "channel_not_found"
      end
    end

    it "will return false for a bogus token" do
      VCR.use_cassette("send_msg") do
        response = SlackApiWrapper.send_msg("test-api-channel","TEST TEST", token: "BOGUS")
        response["ok"].must_equal false
      end
    end


  end

end
