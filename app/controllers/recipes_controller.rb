class RecipesController < ApplicationController

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:q])
  end

  def show
    @recipe = EdamamApiWrapper.get_recipe(params[:r])
  end

end
