require 'test_helper'

describe EdamamApiMuncher do
  describe "search" do
    it "can get a list of recipes" do
      VCR.use_cassette("search") do
        result = EdamamApiMuncher.search("cheese", 10, 20)
        result.must_be_kind_of Array
        result.length.must_be :>, 0
        result.each do |r|
          r.must_be_kind_of Recipe
        end #.each
      end # use_cassette
    end # it
  end # describe

  it "returns an empty array if no items found" do
     VCR.use_cassette("search") do
       result = EdamamApiMuncher.search("bbbbb", 0, 10)
       result.must_be_kind_of Array
       result.empty?.must_equal true
     end
   end

   describe "find" do
     it "should return data of one recipe " do
       # uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289"
       VCR.use_cassette("find") do
         all_recipes = EdamamApiMuncher.search("cheese", 0, 10)
         recipe = all_recipes[0]
         data = EdamamApiMuncher.find(recipe.id)
         data.must_be_kind_of Recipe
       end
     end

     it " should return an empty string if no recipe found " do
       uri = "http://www.edamam.com/ontologies/edamam.owl#recipe_df05891dd71023b6271cb0fc67a88289"
       VCR.use_cassette("find") do
        EdamamApiMuncher.find(uri + "bad_search").must_equal nil
       end
     end
   end
end #EdamamApiMuncher
