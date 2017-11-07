require 'test_helper'

class RecettesControllerTest < ActionDispatch::IntegrationTest
  describe RecettesController do

    it "can get index" do
      VCR.use_cassette("index_action") do
        get root_path
        must_respond_with :success
      end
    end
    it "can get show" do
      VCR.use_cassette("show_action") do
        get recettes_path({"uri" => "http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2"})
        must_respond_with :success
      end
    end
    it "redirect to the root page for invalid recipe uri" do
      VCR.use_cassette("show_action") do
        get recettes_path({"uri" => "http://www.edamam.com/ontologies/edamam.owl%23recipe_f77adf7bf61cbb2fa0d6b290af60"})
        # must_redirect_to root_path

      end
    end
  end

end
