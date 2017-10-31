class RecipesController < ApplicationController

  def search
    @query = params[:query]
    @results = EdamamApiWrapper.search_recipes(@query)
    return @results
    # check if the query is valid
    # if query
    #   @results = EdamamApiWrapper.search_recipes(query)
    #   return @results
    # end
  end

  def show
    @recipe_uri = params[:uri]
    @recipe = EdamamApiWrapper.show_recipe(@recipe_uri)
  end

  # private
  #
  # def recipe_params
  #   params.require(:recipe).permit(:uri, :label, :image, :source, :url, :yield, :calories, :totalWeight, :ingredients, :totalNutrients, :totalDaily, :dietLabels, :healthLabels)
  # end
end
