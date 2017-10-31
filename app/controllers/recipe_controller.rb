class RecipeController < ApplicationController

   def root
   end

  def index
    @query = params[:query]
    @recipes = EdemamApiWrapper.list_recipes(@query)
  end

  def show
    @recipe = EdemamApiWrapper.find_a_recipe(params [:uri])
  end


end
