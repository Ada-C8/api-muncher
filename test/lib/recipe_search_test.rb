require 'test_helper'


describe RecipeSearch do

  let(:recipe) do
    Recipe.new(
      name: "Coffee Syrup",
      image_url: "https://www.edamam.com/web-img/7f9/7f94bbfcc97998f7b11c928ee8488b70.JPG",
      recipe_url: "https://food52.com/recipes/11227-coffee-syrup",
      recipe_uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_17b2813eff91356288deeb23c835a402",
      source: "Food52",
      ingredients: [ "1 1/2 cup espresso or strong coffee", "1 1/2 to 2 cup turbinado sugar" ]
    )
  end

  describe 'self.search' do
    it 'returns an array of Recipes if search has matches' do
      VCR.use_cassette('artichoke') do
        result = RecipeSearch.search('artichoke')

        result.must_be_kind_of Array
        result.each { |r| r.must_be_kind_of Recipe }
      end
    end

    it 'returns an empty array if search has no matches' do
      VCR.use_cassette('NoRecipeWouldHaveThis') do
        result = RecipeSearch.search('NoRecipeWouldHaveThis')

        result.must_equal []
      end
    end

    it 'raises APIError without authentication' do
      VCR.use_cassette('not_authed') do
        proc {
          RecipeSearch.search('cookies')
        }.must_raise RecipeSearch::APIError
      end
    end
  end

  describe 'self.find' do
    it 'returns a Recipe if search has match' do
      VCR.use_cassette('pumpkin') do
        result = RecipeSearch.find(recipe.id)

        result.must_be_kind_of Recipe
      end
    end

    it 'returns nil if search has no match' do
      VCR.use_cassette('whatever') do
        result = RecipeSearch.find("whatever")

        assert_nil result
      end
    end
  end
end
