require 'test_helper'

describe EdamamWrapper do
  it "can return list of recipes" do
    VCR.use_cassette("recipes") do
      recipes = EdamamWrapper.list_recipes
      recipes.must_be_kind of Hash
      recipes.length.must_be :>, 0
      recipes.each do |recipe|
        recipe.must_be_instance_of Recipe
      end
    end
  end

  it "does something when the app key is bad" do
    VCR.use_cassette("recipes") do
      proc {
      result = EdamamWrapper.list_recipes("bogus_appkey")
    }.must_raise EdamamWrapper::ApiError
      puts "In the failure case, result is #{result}"
    end
  end
end
