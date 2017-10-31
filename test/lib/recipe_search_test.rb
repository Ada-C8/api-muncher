require "test_helper"

describe RecipeSearch do
  describe 'self.search' do
    it 'returns an array of Recipes if search has matches' do
      VCR.use_cassette('artichoke') do
        result = RecipeSearch.search('artichoke')

        result.must_be_kind_of Array
        result.each {|r| r.must_be_kind_of Recipe}
      end
    end

    it 'returns an empty array if search has no matches' do
      VCR.use_cassette('NoRecipeWouldHaveThis') do
        result = RecipeSearch.search('NoRecipeWouldHaveThis')

        result.must_equal []
      end
    end
  end
end
