class RecipeController < ApplicationController
  def list_search
    @recipes = EdamamApiWrapper.search(params["q"])
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params["recipe"])
  end
end
