require 'test_helper'

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
  let(:optional_params) {
    {
      dietary_info: {
        "ENERC_KCAL": {
          "label": "Energy",
          "quantity": 1414.0200000000002,
          "unit": "kcal"
        },
        "FAT": {
          "label": "Fat",
          "quantity": 0.07110000000000001,
          "unit": "g"
        },
        "CHOCDF": {
          "label": "Carbs",
          "quantity": 352.793,
          "unit": "g"
        },
        "PROCNT": {
          "label": "Protein",
          "quantity": 0.4266,
          "unit": "g"
        }
      },
      diet_labels: [
        "Vegan",
        "Vegetarian",
        "Peanut-Free",
        "Tree-Nut-Free",
        "Alcohol-Free"
      ]
    }
  }

  it 'can be instantiated with minimum attributes' do
    recipe = Recipe.new(recipe_params)

    recipe.must_be_kind_of Recipe
  end

  it 'can be instantiated with optional attributes' do
    recipe_params.merge(optional_params)
    recipe = Recipe.new(recipe_params)

    recipe.must_be_kind_of Recipe
  end

  it 'raises ArgumentError if missing required attribute' do
    recipe_params.delete(:source)

    proc {
      Recipe.new(recipe_params)
    }.must_raise ArgumentError
  end

  describe 'attributes' do
    it 'can access required attributes' do
      recipe = Recipe.new(recipe_params)

      recipe.must_respond_to :name
      recipe.must_respond_to :image_url
      recipe.must_respond_to :recipe_url
      recipe.must_respond_to :source
      recipe.must_respond_to :ingredients
    end

    it 'can access optional attributes' do
      recipe_params.merge(optional_params)
      recipe = Recipe.new(recipe_params)

      recipe.must_respond_to :dietary_info
      recipe.must_respond_to :diet_labels
    end
  end
end
