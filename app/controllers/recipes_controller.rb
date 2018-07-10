class RecipesController < ApplicationController
  def welcome
  end

  def index
    if params[:search_term] == nil
      return redirect_to root_path
    end

    @recipes = EdamamApiWrapper.list_recipes(params[:search_term]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:id])

    if @recipe == nil
      flash[:error] = "Recipe not found"
      redirect_to root_path
    end
  end
end
