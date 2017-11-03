require 'test_helper'

describe EdemamApiWrapper do

  describe "list_recipes" do
    it "Can send find recipes" do
      VCR.use_cassette("recipes") do
        search_term = "chicken"
        response = EdemamApiWrapper.list_recipes(search_term)
        response.count.must_be :>, 0
        #response["message"]["text"].must_equal message
      end
    end

    #it raises an argument if recipe is not in?
  end

  #why is this returning a fine response?
  it "Raises an ApiError when the token is bad" do
    VCR.use_cassette("recipes") do
       proc {
      EdemamApiWrapper.list_recipes("chicken", "bogus_token")
       }.must_raise EdemamApiWrapper::ApiError
    end
  end

  describe "find_a_recipe" do
    it "Can find a single recipe with a uri" do
      VCR.use_cassette("recipes") do
        uri ="http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682a72808da7dc2"
        result = EdemamApiWrapper.find_a_recipe(uri)
        result.must_be_kind_of Recipe
        result.label.must_equal "Teriyaki Chicken"
      end
    end

    it "Raises an ApiError when the uri is bogus" do
      VCR.use_cassette("recipes") do
        uri ="http://www.edamam.com/ontologies/edamam.owl%23recipe_7bf4a371c6884d809682abogus"
        proc {
        EdemamApiWrapper.find_a_recipe(uri)
        }.must_raise EdemamApiWrapper::ApiError
      end
    end


    #check is the uri is bad?
  end
end
