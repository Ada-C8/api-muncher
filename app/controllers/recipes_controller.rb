class RecipesController < ApplicationController
  def welcome
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search_term])
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:id])
  end

end
