class RecipesController < ApplicationController
  def main; end

  def index
    @recipes = EdamamApiWrapper.search(params[:q])
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
  end
end
