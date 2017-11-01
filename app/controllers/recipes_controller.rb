require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'



class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])
  end

  # def new
  # end
  #
  # def create
  # end

end
