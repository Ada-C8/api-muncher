class RecipesController < ApplicationController
  def index
     @search = params[:item]
     @from = (params[:from]) ? params[:from].to_i : 0
     @previous_from = @from - 10
     @from += 10

     if params[:item]
       @recipes = EdamamWrapper.list_recipes(params[:item], @from)
     else
       @recipes = nil
     end
  # binding.pry
  # @recipes = EdamamWrapper.list_recipes(params[:item])
  # @recipes = EdamamWrapper.order(:item).page params[:page]
  end

  def show
    @recipe = EdamamWrapper.find_recipe(params[:id])
  end
end
