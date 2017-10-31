class RecipesController < ApplicationController
  def index
    # @recipes = EdamamApiWrapper.all_recipes
    # @recipes = Recipe.all
    # if params[:query]
    #   @recipes = Recipe.search(params[:query]).order("created_at DESC")
    # else
    #   @recipes = Recipe.all.order("created_at DESC")
    # end
  end

  def new
    # @recipe = params[:recipe]
  end

  def search
    query = params[:query]
    @results = EdamamApiWrapper.search_recipes(query)
    return @results
    # if query
    #   @results = EdamamApiWrapper.search_recipes(query)
    #   return @results
    # end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:uri, :label, :image, :source, :url, :yield, :calories, :totalWeight, :ingredients, :totalNutrients, :totalDaily, :dietLabels, :healthLabels)
  end
end
