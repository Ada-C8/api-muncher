require 'test_helper'

describe EdamamApiWrapper do
  describe "search_recipes" do
    it "Can get a list of recipes" do
      VCR.use_cassette("recipes") do
        query = "eggs"
        response = EdamamApiWrapper.search_recipes(query)
        response.must_be_kind_of Array
        response.length.must_be :>, 0
      end
    end
  end

  describe "show_recipe" do
    it "Will show recipe if given uri" do
      VCR.use_cassette("recipes") do
        uri = "recipe_7d222a612deb4bc263532f75d4071da1"
        result = EdamamApiWrapper.show_recipe(uri)
        result.parsed_response.must_be_kind_of Array
      end
    end

    # it "Raises an ApiError if the uri does not exist" do
    #   VCR.use_cassette("channels") do
    #     proc {
    #       SlackApiWrapper.send_msg("channel-that-doesnt-exist", "test message")
    #     }.must_raise SlackApiWrapper::ApiError
    #   end
    # end
    #
    # it "Raises an ApiError if not given a uri" do
    #   VCR.use_cassette("channels") do
    #     proc {
    #       SlackApiWrapper.send_msg("test-api-channel", "")
    #     }.must_raise SlackApiWrapper::ApiError
    #   end
    # end
  end
end
