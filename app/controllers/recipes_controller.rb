class RecipesController < ApplicationController

  def index
    if params[:term] == nil or params[:term] == ""
      @recipes = EdamamApiWrapper.search
    else
      @recipes = EdamamApiWrapper.search(params[:term])
    end
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])
  end
end
