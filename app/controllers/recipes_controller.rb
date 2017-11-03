class RecipesController < ApplicationController

  def root

  end

  def search
    @recipes = EdamamApiWrapper.search_recipes(params[:query])
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:query])
  end
end
