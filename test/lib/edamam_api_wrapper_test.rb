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

  end

end
