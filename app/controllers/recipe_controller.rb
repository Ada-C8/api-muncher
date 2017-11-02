class RecipeController < ApplicationController

   def root
   end

  def index
    @query = params[:query]
    @recipes = EdemamApiWrapper.list_recipes(@query)
    if @recipes == []
      flash.now[:status] = "failure"
      flash.now[:message] = "No recipes could be found for #{@query}"
      render :root
    end

  end

  def show
    @recipe = EdemamApiWrapper.find_a_recipe(params["uri"])
  end


end
