require "test_helper"

describe RecipesController do
  it "can view the home page" do
    VCR.use_cassette("home") do
      get root_path
      must_respond_with :success
    end
  end

  it "can view the search page" do
    VCR.use_cassette("index") do
      get recipes_path(EdamamApiWrapper.search("chocolate"))
      must_respond_with :success
    end
  end

  it "can view the show page" do
    VCR.use_cassette("index") do
      get recipes_path(EdamamApiWrapper.view_recipe("http://www.edamam.com/ontologies/edamam.owl#recipe_8643e0c3105bcb0d3c3a417308a09c03"))
      must_respond_with :success
    end
  end

end
