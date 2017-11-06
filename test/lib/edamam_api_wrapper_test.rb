require 'test_helper'

describe EdamamApiWrapper do
  describe "Search Recipe Results" do
    it "returns a collection of recipes" do
      VCR.use_cassette("search_q_results") do
        search = "kimchee"
        results = EdamamApiWrapper.search_recipe_results(search)

        results.must_be_kind_of Array
        results.count.must_be :>, 0
        results.each do |result|
          result.must_be_instance_of Recipe
        end

      end
    end

    it "will return an empty array for a broken request" do

      VCR.use_cassette("search_q_results") do
        search = "kimchee"
        results = EdamamApiWrapper.search_recipe_results(search, "BOGUS ID", "BOGUS KEY")

        results.must_be_instance_of Array
        results.must_equal []
      end

    end

    it "works for search terms that have multiple words or white spaces" do
      VCR.use_cassette("search_q_results") do
        search = "lemon tart"
        results = EdamamApiWrapper.search_recipe_results(search)

        results.must_be_kind_of Array
        results.count.must_be :>, 0
        results.each do |result|
          result.must_be_instance_of Recipe
        end

      end

    end

    it "returns a maximum of 100 results" do
      VCR.use_cassette("search_q_results") do
        search = "chicken"
        results = EdamamApiWrapper.search_recipe_results(search)

        results.count.must_be :<, 101
      end

    end

    it "will return an empty array for a search that has no results" do

      VCR.use_cassette("search_q_results") do
        non_exist_search = "bogus123"
        results = EdamamApiWrapper.search_recipe_results(non_exist_search)

        results.must_be_kind_of Array
        results.count.must_equal 0
      end

    end

  end

  describe "create recipe" do

    before do
      @sample_api_params= {
        "recipe"=> {
          "uri"=>"uri.recipe.com",
          "label"=>"Yummy in my Tummy",
          "image"=>"yummy.png",
          "source"=>"Recipes",
          "url"=>"recipe.com/yummy_in_my_tummy",
          "yield"=>4.0,
          "ingredientLines"=>[
            "1 surprise",
            "1 dash yum",
            "3 snaps"
          ],
          "dietLabels"=>[
            "Very Healthy"
          ]
        }
      }
    end

    it "successfully creates a Recipe from API params given" do

      result = EdamamApiWrapper.create_recipe(@sample_api_params["recipe"])
      result.must_be_instance_of Recipe
    end

    it "creates a Recipe with optional attributes that default to nil if optional info is not provided by the api" do
        result = EdamamApiWrapper.create_recipe(@sample_api_params["recipe"])

        result.must_respond_to :total_daily
        result.must_respond_to :calories
        result.must_be_instance_of Recipe

        result.calories.must_equal nil
        result.total_daily.must_equal nil

    end


  end

  describe "Find Recipe" do
    it "returns a single recipe" do
      VCR.use_cassette("find_recipe") do
        search = "kimchee"
        results = EdamamApiWrapper.search_recipe_results(search)
        first_result = results.first

        first_uri = first_result.uri
        recipe = EdamamApiWrapper.find_recipe(first_uri)

        recipe.must_be_instance_of Recipe
        recipe.name.must_equal "Kitchen Sink Kimchee Soup"
      end

    end

    it "will return false for a broken request" do

      VCR.use_cassette("find_recipe") do
        search = "meyer lemon"
        results = EdamamApiWrapper.search_recipe_results(search)
        first_result = results.first

        first_uri = first_result.uri

        recipe = EdamamApiWrapper.find_recipe(first_uri, "BOGUS_ID", "BOGUS_KEY")

        recipe.must_equal false
      end

    end

    it "will return false for a recipe that doesn't exist" do

      VCR.use_cassette("find_nonexist_recipe") do
        bogus_uri = "http://scam.bogus.com"

        recipe = EdamamApiWrapper.find_recipe(bogus_uri)

        recipe.must_equal false
      end

    end


  end

end
