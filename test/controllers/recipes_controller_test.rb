require 'test_helper'

# class RecipesControllerTest < ActionDispatch::IntegrationTest
describe RecipesController do


  describe "INDEX" do
    it "Can get a list of recipes" do
      VCR.use_cassette("index_action") do
        # binding.pry
          get recipes_path
          must_respond_with :success
        end
    end


  end

  # describe "SHOW" do
  #   it "Can show an individual recipe " do
  #
  #   end
  # end


end
