require "test_helper"

describe Recipe do

  let(:recipe_params) {
    {
      name: "Coffee Syrup",
      image_url: "https://www.edamam.com/web-img/7f9/7f94bbfcc97998f7b11c928ee8488b70.JPG",
      recipe_url: "https://food52.com/recipes/11227-coffee-syrup",
      source: "Food52",
      ingredients: [ "1 1/2 cup espresso or strong coffee", "1 1/2 to 2 cup turbinado sugar" ]
    }
  }

  it 'can be instantiated' do
    recipe = Recipe.new(recipe_params)

    recipe.must_be_kind_of Recipe
  end

  it 'raises ArgumentError if missing attribute' do
    recipe_params.delete(:source)

    proc {
      recipe = Recipe.new(recipe_params)
    }.must_raise ArgumentError
  end

  describe 'attributes' do

  end
end
