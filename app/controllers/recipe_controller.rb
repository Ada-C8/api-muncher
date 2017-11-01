class RecipeController < ApplicationController
  def home

  end

  def index
    # @recipes = Recipe.all
    if params[:search]
      @recipes = EdamamApiWrapper.search_recipe_results(params[:search])
    else
      flash[:failure] = "No search term entered"
      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamaApiWrapper.show_recipe(params["recipe"])
  end

end
