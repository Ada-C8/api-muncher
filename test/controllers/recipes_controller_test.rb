require 'test_helper'

describe RecipesController do
  describe "index" do
    it "must respond with success" do
      get root_path
      must_respond_with :success
    end
  end

  # describe "show" do
  #   it "returns a success status when passed a valid uri" do
  #     VCR.use_cassette("show_recipe") do
  #       label = "test_label"
  #       uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
  #       recipe = EdamamWrapper.find_recipe(uri)
  #       recipe.must_be_kind_of Recipe
  #       get recipe_path(label: label, uri: uri)
  #       must_respond_with :success
  #     end
  # #   end
  # end
end
