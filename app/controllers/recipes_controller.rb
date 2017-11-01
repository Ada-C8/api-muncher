class RecipesController < ApplicationController


  def index
    if params[:search]
      @recipes = RecipeApiWrapper.search(params[:search])
    else
      @recipes = nil
    end
  end

  def show
    @recipe = RecipeApiWrapper.find(params[:id])
  end

end
