require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def search_form
  end

  def index
    @recipes = EdamamApiWrapper.search_recipes(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @recipe = EdamamApiWrapper.recipe_details(params[:uri])
  end
end
