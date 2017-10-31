require "test_helper"

describe RecipesController do
  it "should get index" do
    VCR.use_cassette("index_action") do
      get recipes_path, params: {search: "coffee"}
      must_respond_with :success

      get recipes_path, params: {search: " "}
      must_respond_with :success
    end
  end

  it "should save recent searches" do
    VCR.use_cassette("index_action") do
      get recipes_path, params: {search: "salad"}
      get recipes_path, params: {search: "coffee"}
      session[:recent_searches].must_be_instance_of Hash
      session[:recent_searches].length.must_equal 2
    end
  end

  it "should get show" do
    VCR.use_cassette("show_action") do
      uri = "bcbbb3cd875fa61b5601231a709812a6"
      get recipe_path(uri)
      must_respond_with :success
    end
  end

  it "should render_404 for bogus show" do
    VCR.use_cassette("show_action") do
      uri = "BOGUS"
      get recipe_path(uri)
      must_respond_with :not_found
    end
  end

  it "should get root" do
    VCR.use_cassette("root_action") do
      get root_path
      must_respond_with :success
    end
  end

end
