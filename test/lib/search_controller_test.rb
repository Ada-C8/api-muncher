require 'test_helper'

describe SearchController do
  it "succeeds getting to root path" do
    get root_path
    must_respond_with :success
  end

  it "succeeds for the create action to generate search results for popular query" do
    VCR.use_cassette("list_all") do
      get search_results_path("chicken")
      must_respond_with :success
    end
  end

  it "succeeds for the create action to generate search results for longer query" do
    VCR.use_cassette("list_all") do
      get search_results_path("chicken, lemon, balsamic")
      must_respond_with :success
    end
  end

  it "succeeds in showing information about a single recipe" do
    VCR.use_cassette("list_another_one") do
      # get search_results_path("lemon")
      # get show_recipe_path(params: {:uri =>"http://www.edamam.com/ontologies/edamam.owl%23recipe_88f6c6167b43fe6754446675fe4e1945", :title =>"Lemon Sorbet"})
      # must_respond_with :success
    end
  end


end
