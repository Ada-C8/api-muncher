require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:query] || "chocolate")
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])
  end
end
