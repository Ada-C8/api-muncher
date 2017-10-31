require 'test_helper'

describe EdamamApiWrapper do
  it "can get a list of all recipes" do
    VCR.use_cassette("recipes") do # This can be named whatever we want and it will create a YML recipe file in the fixtures folder
      response = EdamamApiWrapper.search("chicken")
      response["ok"].must_equal false
      response["error"].wont_be_nil
      response.must_be_kind_of Array
      response.each do |recipe|
        recipe.must_be_kind_of Recipe
      end
      reseponse.length.must_be :>, 0 # There must be at least one recipe, if there 0 channels, it means that we cannot communicate with the API
    end
  end

  # Does something when the token is bad!
  # In order to make the call fail, we should change the KEY and the ID to maket the call fail
  # Use the same cassette as the channels to record the action
  # Add token=TOKEN as a parameter in the APIWrapper

  # VCR.user_cassette("channels") do
  # result = SlackApiWrapper.list_channels("bogus_token")
  
end
