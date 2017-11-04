require_dependency '../../lib/muncher_api_wrapper'
require_dependency '../../lib/recipe'


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
