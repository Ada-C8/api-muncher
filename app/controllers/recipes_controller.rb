require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def root
    @random = ["water", "sourdough bread", "tacos", "pizza", "chocolate chip cookies", "liver", "garbage"].sample
    @all = EdamamApiWrapper.food_options
  end

  def index
    @recipes = EdamamApiWrapper.search_recipes(params[:search]).paginate(:page => params[:page], :per_page => 9)

    if @recipes.empty?
      flash[:error] = "Sorry, there are no results for #{params[:search]}"
      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamApiWrapper.recipe_details(params[:uri])
  end
end
