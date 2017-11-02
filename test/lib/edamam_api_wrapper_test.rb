require 'test_helper'

describe EdamamApiWrapper do

  describe "self.list_recipes" do
    it "can get first 10 recipes given a search term" do
      VCR.use_cassette("recipes") do
        search = "chicken"
        recipes = EdamamApiWrapper.list_recipes(search, 0)

        recipes.count.must_equal 10
        recipes.must_be_instance_of Array
        recipes.each { |recipe| recipe.must_be_instance_of Recipe }
      end
    end

    it "will return an empty array if given empty string as search param" do
      VCR.use_cassette("recipes") do
        search = ""
        recipes = EdamamApiWrapper.list_recipes(search, 0 )
        recipes.must_equal []
      end
    end

    describe "self.get_recipe" do
      it "can retrieve a recipe " do
        VCR.use_cassette("recipes") do
          id = "http://www.edamam.com/ontologies/edamam.owl#recipe_8275bb28647abcedef0baaf2dcf34f8b"
          paprikash = EdamamApiWrapper.get_recipe(id)
          paprikash.must_be_instance_of Recipe
          paprikash.title.must_equal "Chicken Paprikash"
        end
      end

      it "doesn't find recipe if invalid param" do
        VCR.use_cassette("recipes") do
          id = "blah blah blah"
          test_recipe = EdamamApiWrapper.get_recipe(id)
          test_recipe.must_equal nil
        end
      end
    end

    it "must not render same recipe on different page" do
      titles = []

      VCR.use_cassette("recipes") do
        query = "chicken"
        recipes = EdamamApiWrapper.list_recipes(query, 0)
        recipes.each { |recipe| titles << recipe.title }

        recipes = EdamamApiWrapper.list_recipes(query, 10)
        recipes.each { |recipe| titles << recipe.title}
      end
      titles.uniq.count.must_equal 19
    end

  end
end
