require 'test_helper'

describe EdamamApiWrapper do

  describe "self.query" do
    # not getting any results back (getting empty array)
    it "can do a query" do
      VCR.use_cassette("query") do
        query = "tofu"
        results = EdamamApiWrapper.query(query)

        results.must_be_instance_of Array
        p results
        puts results.length
        results.length.must_be :>, 0
        results.each do |result|
          result.must_be_instance_of Recipe
        end
      end
    end

  end # end of self.query
end # end of EdamamApiWrapper
