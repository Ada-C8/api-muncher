class RecipesController < ApplicationController
  def welcome
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search_term]).paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:id])
  end

end
