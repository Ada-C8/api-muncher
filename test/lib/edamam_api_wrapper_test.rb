require 'test_helper'
require_relative '../helpers/fake_response'

describe EdamamApiWrapper do

  describe "get_search_url" do
    it "returns the complete url of the search request path" do
      VCR.use_cassette("recipes") do
        url = EdamamApiWrapper.get_search_url("fish", 0, 9)

        url.must_equal "https://api.edamam.com/search?q=fish&from=0&to=9&app_id=#{ENV["APP_ID"]}&app_key=#{ENV["APP_KEY"]}"
      end
    end
  end

  describe "search" do
    it "receives a valid response for a search" do
      VCR.use_cassette("recipes") do
        response = EdamamApiWrapper.search("fish", 0, 9)

        response.length.must_be :>, 0
        response.must_be_kind_of HTTParty::Response
      end
    end
  end

  describe "get_results_from_response" do
    it "returns an array of Recipe objects" do
      VCR.use_cassette("recipes") do
        response = EdamamApiWrapper.search("fish", 0, 9)

        arr = EdamamApiWrapper.get_results_from_response(response)

        arr.must_be_kind_of Array
      end
    end

    it "returns an empty array if there are no search results" do
      VCR.use_cassette("recipes") do
        response = {"hits"=>[]}

        EdamamApiWrapper.get_results_from_response(response).must_equal []
      end
    end
  end

  describe "create_recipe" do
    it "returns a single recipe using the uri as an id" do
      VCR.use_cassette("recipes") do
        # uri for tuna confit
        uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_f6f7b9562cd7bf5950058ce8bc189c26"

        tuna_confit = EdamamApiWrapper.create_recipe(uri)

        tuna_confit.name.must_equal "Tuna Confit"
      end
    end
  end
  describe "check_status" do
    it "raises an ApiError if the response code is not 200" do
      VCR.use_cassette("recipes") do
        # created a helper class in test/helpers because idk how to fake response codes
        response = FakeResponse.new(400)

        proc { EdamamApiWrapper.check_status(response) }.must_raise EdamamApiWrapper::ApiError
      end
    end
  end

# test fails
  describe "get_recipe" do
    it "creates a Recipe object" do
      VCR.use_cassette("recipes") do
        recipe = EdamamApiWrapper.search("fish", 0, 9)

        EdamamApiWrapper.get_recipe(recipe["hits"][0]).must_be_kind_of Recipe
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
