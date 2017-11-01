require "test_helper"

describe RecipeController do
  it "should get index" do
    skip
    get recipe_index_url
    value(response).must_be :success?
  end

  it "should get show" do
    skip
    get recipe_show_url
    value(response).must_be :success?
  end

end
