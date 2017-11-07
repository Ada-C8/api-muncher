class RecipesController < ApplicationController
  def welcome
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes
    # (params[:search_term]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:id])

    if @recipe
      flash[:success]
    else
      flash[:error] = "Recipe not found"
      redirect_to recipes_path
    end
  end
end
