require 'test_helper'

describe "EdamamApiWrapper" do
  describe "search" do
    it "can get a search" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("chicken")
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |recipe|
          recipe.must_be_kind_of Recipe
        end
      end
    end

    it "returns an empty array if no items are found" do
      VCR.use_cassette("search") do
        result = EdamamApiWrapper.search("lkuguyfyrd")
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

    it "returns empty string if uri is bad" do
      VCR.use_cassette("find_recipe") do
        EdamamApiWrapper.find_recipe(@uri + "lalala").must_equal nil
      end
    end
  end
end
