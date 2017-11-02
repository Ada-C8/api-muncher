require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  describe "index" do
    it "can get the list of found recipes" do
      VCR.use_cassette("index_action") do
        get root_path
        must_respond_with :success
      end
    end
  end

  

end
