require 'test_helper'
require 'httparty'

describe EdamamApiWrapper do
  it "Can find all recipes that match a search" do
    VCR.use_cassette("list_all") do
      search = EdamamApiWrapper.find_recipes("chicken")
      search.must_be_instance_of Search
      search.hits.length.must_be :>, 0
    end
  end

  it "will return empty array for broken request" do
    VCR.use_cassette("fake") do
      search = EdamamApiWrapper.find_recipes("there is no way mummies cats broken glass")

      search.must_be_instance_of Array
      search.count.must_equal 0

    end
  end
  #
  # it "can send a message to a channel" do
  #   VCR.use_cassette("send_msg") do
  #     response = SlackApiWrapper.send_msg("test-api-channel", "Another Test Case")
  #     response["ok"].must_equal true
  #   end
  # end
  #
  # it "can't send a message to a fake channel" do
  #   VCR.use_cassette("send_msg") do
  #     response = SlackApiWrapper.send_msg("FAKE FAKE FAKE", "Another Test Case")
  #     response["ok"].must_equal false
  #     response["error"].must_equal "channel_not_found"
  #   end
  # end

end
