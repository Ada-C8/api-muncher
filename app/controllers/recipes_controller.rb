require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def home

  end

  def index
    @recipes = EdamamApiWrapper.query(params[:search])
    if @recipes.length == 0
      flash[:success] = "No search results found -- Please try a different search"
      redirect_to root_path
    end 
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:uri])
  end

end
