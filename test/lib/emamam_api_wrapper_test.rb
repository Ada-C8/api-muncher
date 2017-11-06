require 'test_helper'

describe "EdamamApiWrapper" do
  describe "search" do
    it "can perform a search" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("apple")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "returns an empty array if no items are found" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("zzzzmmmaaakkkksss")
        result.must_be_kind_of Array
        result.empty?.must_equal true
      end
    end
  end

  describe "find_recipe" do
    before do
      @uri = "http://www.edamam.com/ontologies/edamam.owl%23recipe_f77adf7b01a1f61cbb2fa0d6b290af60"
    end
    it "gets one instance of recipe" do
      VCR.use_cassette("find_recipe") do
        result = EdamamApiWrapper.find_recipe(@uri)
        result.must_be_kind_of Recipe
        result.id.must_equal @uri
      end
    end
    it "returns empty string if wrong uri" do
      VCR.use_cassette("find_recipe") do
        EdamamApiWrapper.find_recipe(@uri + "zzzzmmmaaakkkksss").must_equal ""
      end
    end
  end
end
