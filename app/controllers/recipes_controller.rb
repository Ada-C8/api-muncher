class RecipesController < ApplicationController
  def index
    @recipes = MuncherApiWrapper.find_recipes(params[:word], params[:page])
  end

  def show
    @recipe = MuncherApiWrapper.one_recipe(params[:id])
    unless @recipe
      head :not_found
    end
  end
end
