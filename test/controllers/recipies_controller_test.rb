require "test_helper"

describe RecipiesController do
  describe "root" do
    it "will return success" do
      get root_path
      must_respond_with :success
    end # success
  end # root

  describe "index" do
    it "will return success when there are recipies to display" do
      VCR.use_cassette("recipes") do
        test_params = {
          search_term: "bread"
        }

        get recipies_path, params: test_params
        must_respond_with :success
      end # VCR
    end # sucess when there are recipies

    it "will return not_found when there are no recipies returned to display because the search tearm has symbols or numbers in it" do
      # TODO: make a call with a bad search term that won't return any recipies. Need to figure out in my controller how to redirect to the root page if the request was bad... maybe check 'if @response' ?
      VCR.use_cassette("recipes") do
        test_params = {
          search_term: "bread#"
        }

        get recipies_path, params: test_params
        must_respond_with :redirect
        must_redirect_to root_path
      end # VCR
    end # redirects when search term has a symbol in it

    it "will return not_found when there are no recipies returned to display because the search tearm was empty" do
      VCR.use_cassette("recipes") do
        test_params = {
          search_term: ""
        }

        get recipies_path, params: test_params
        must_respond_with :redirect
        must_redirect_to root_path
        flash[:message].must_equal "Sorry, your search term can't be blank!"
      end # VCR
    end # redirects with empty search term
  end # index

  describe "show" do
    it "will respond with success when there is a recipe to show" do
      # TODO: Make a request with shoe_recipe and then make sure the show page shows up
      VCR.use_cassette("recipies") do
        test_params = {
          uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_7bf4a371c6884d809682a72808da7dc2"
        }
        name = "name"

        get recipy_path(name), params: test_params
        must_respond_with :success
      end # VCR
    end # success

    it "will respond with not_found if the show_recipe does not return a Recipe" do
      # TODO: Make a request with show_recipe with a bogus uri, then the controller should check if @recipe exisits, and if it doesn't it should return not_found

      VCR.use_cassette("recipies") do
        test_params = {
          uri: "bogus_uri"
        }
        name = "name"

        get recipy_path(name), params: test_params
        must_respond_with :not_found
      end # VCR
    end # not_found
  end # show
end
