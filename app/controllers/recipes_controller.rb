class RecipesController < ApplicationController
  def root

  end

  def index
    @query = params[:query]
    @recipes = EdamamApiWrapper.search(@query)

    if @recipes.empty?
      flash[:status] = :failure
      flash[:message] = "No recipes were found for that query."

      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:recipe_id])
  end

end
