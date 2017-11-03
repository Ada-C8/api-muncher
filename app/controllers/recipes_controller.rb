require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    @query = params[:query]
    @recipes = EdamamApiWrapper.search(@query).paginate(:page => params[:page], :per_page => 10)

    if @recipes.empty?
      flash[:status] = :failure
      flash[:message] = "No recipes found, please try again."
      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:recipe_id])

    if @recipe == ""
      flash[:status] = :failure
      flash[:message] = "No recipes found, please try again."
      redirect_to root_path
    end
  end

end
