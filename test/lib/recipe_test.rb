require 'test_helper'

describe Recipe do
  before do
    VCR.use_cassette("list_all") do
      response = EdamamApiWrapper.show_recipe("http://www.edamam.com/ontologies/edamam.owl%23recipe_88f6c6167b43fe6754446675fe4e1945")[0]

      @recipe = Recipe.new(response)
    end
  end

  it "initializes" do
    @recipe.must_be_instance_of Recipe
  end

  it "must respond to attributes" do
    @recipe.must_respond_to :uri

    @recipe.must_respond_to :title
    @recipe.title.must_equal "Lemon Sorbet"

    @recipe.must_respond_to :ingredients
    @recipe.ingredients.must_be_instance_of Array

    @recipe.must_respond_to :calories
    @recipe.must_respond_to :health_labels
    @recipe.health_labels.must_be_instance_of Array

    @recipe.must_respond_to :diet_labels
    @recipe.diet_labels.must_be_instance_of Array

    @recipe.must_respond_to :image
    @recipe.must_respond_to :link
  end
end
