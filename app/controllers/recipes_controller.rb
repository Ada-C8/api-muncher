class RecipesController < ApplicationController


  def index
    @search = params[:search]
    @from = (params[:from]) ? params[:from].to_i : 0
    @previous_from = @from - 10
    @from += 10

    if params[:search]
      @recipes = RecipeApiWrapper.search(params[:search], @from)
    else
      @recipes = nil
    end
  end

  def show
    @recipe = RecipeApiWrapper.find(params[:id])
  end

end
