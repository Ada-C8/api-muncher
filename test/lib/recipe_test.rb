require 'test_helper'

describe Recipe do

  let(:recipe_params) {
    {
      name: "Coffee Syrup",
      image_url: "https://www.edamam.com/web-img/7f9/7f94bbfcc97998f7b11c928ee8488b70.JPG",
      recipe_url: "https://food52.com/recipes/11227-coffee-syrup",
      recipe_uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_17b2813eff91356288deeb23c835a402",
      source: "Food52",
      ingredients: [ "1 1/2 cup espresso or strong coffee", "1 1/2 to 2 cup turbinado sugar" ],
      nutrition: {
        "ENERC_KCAL" => {
          "label" => "Energy",
          "quantity" => 1414.0200000000002,
          "unit" => "kcal"
        }
      },
      servings: 4
    }
  }
  let(:optional_params) {
    {
      diet_labels: [
        "Vegan",
        "Vegetarian",
        "Peanut-Free",
        "Tree-Nut-Free",
        "Alcohol-Free"
      ]
    }
  }
  let(:recipe) { Recipe.new(recipe_params) }

  it 'can be instantiated with minimum attributes' do
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
      recipe.must_respond_to :id
      recipe.must_respond_to :name
      recipe.must_respond_to :image_url
      recipe.must_respond_to :recipe_url
      recipe.must_respond_to :source
      recipe.must_respond_to :ingredients
      recipe.must_respond_to :nutrition
      recipe.must_respond_to :servings
    end

    it 'can access optional attributes' do
      recipe_params.merge(optional_params)
      recipe = Recipe.new(recipe_params)

      recipe.must_respond_to :diet_labels
    end
  end

  describe 'nutrition info' do
    it 'prints basic nutrition info to an array, divided by servings' do
      result = recipe.basic_nutrition

      result.must_be_kind_of Array
      result[0][0].must_equal "Energy"
      result[0][1].must_equal "353.51 kcal"
    end
  end
end
