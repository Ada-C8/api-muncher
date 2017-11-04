class RecipesController < ApplicationController

  def root; end

  def index
    @recipes = EdamamApiWrapper.search_recipes(params[:query])
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:recipe])
  end
end
