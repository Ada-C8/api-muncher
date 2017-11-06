require 'test_helper'

describe Recipe do
  it "can create a new recipe when all required paramaters are provided" do
    params = {
      name: "test name",
      link: "test link",
      image: "test image",
      ingredients: "test ingredents",
      uri: "test uru",
      dietary:"test dietary"
    }

    recipe = Recipe.new(params[:name], params[:link], params[:image], params[:ingredients], params[:uri], params[:dietary])
    recipe.must_be_instance_of Recipe
  end

  it "will not create an isntance of recipe if given incomplete data" do
      params = {
        name: "test name",
        link: "test link",
        image: "test image",
        ingredients: "test ingredents",
        uri: "test uri",
        dietary:"test dietary"
      }

      proc {Recipe.new(params[:name], params[:link], params[:image], params[:ingredients], params[:uri], nil)}.must_raise ArgumentError

      proc {Recipe.new(params[:name], params[:link], params[:image], params[:ingredients], nil, params[:uri])}.must_raise ArgumentError

      proc {Recipe.new(params[:name], params[:link], params[:image], nil, params[:ingredients], params[:uri])}.must_raise ArgumentError
    end
end
