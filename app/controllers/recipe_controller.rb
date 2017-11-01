class RecipeController < ApplicationController
  def show
    @recipe = EdamamApiWrapper.find_recipe(params["recipe"])
  end

  def search
    @recipes = EdamamApiWrapper.search(params["q"])
  end
end
