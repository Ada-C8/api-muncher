class RecipesController < ApplicationController

  def index
    @recipes = EdamamApiWrapper.search(params[:term])
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])
  end
end
