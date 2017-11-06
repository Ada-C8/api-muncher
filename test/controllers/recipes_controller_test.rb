require "test_helper"

describe RecipesController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
  describe 'show' do
    it 'uses the uri as the id' do
      VCR.use_cassette("recipes") do

        recipe_id = EdamamApiWrapper.create_recipe("http://www.edamam.com/ontologies/edamam.owl#recipe_f6f7b9562cd7bf5950058ce8bc189c26")

        recipe_id.uri.must_equal "f6f7b9562cd7bf5950058ce8bc189c26"
      end
    end
  end

  describe 'search' do
    it 'displays results from a search' do
      VCR.use_cassette("recipes") do
        response = EdamamApiWrapper.search("fish", 0, 9)
        recipes = EdamamApiWrapper.get_results_from_response(response)

        recipes[0].must_be_kind_of Recipe
      end
    end

    # it 'displays 10 results at a time' do
    #   VCR.use_cassette("recipes") do
        # uses the recipe helper to find the current page number, and display from the (page number * 10)-10 (to get to the 0 index in the results) through the page number * 10 (to get the 9 index)
    #   end
    # end

    # it 'moves forward a page' do
    #   VCR.use_cassette("recipes") do
    #     same principle as the above test, and uses those params to append to the url

    #     so if the current page is less than or equal to the total number of hits, add 1 to the page number in the url (including the q search term)
    #   end
    # end
    #
    # it 'goes to the previous page (only if there is one)' do
    #   VCR.use_cassette("recipes") do
    #     if the current page number is 1, there won't be a previous link
    #     if the page is greater than 1, subtract 1 from it and append it to the search url (with it's q search term)
    #   end
    # end

    # it 'it displays a message if there are no results' do
    #   VCR.use_cassette("recipes") do
    #     # not sure how to test flash messages
    #   end
    # end
  end
end
