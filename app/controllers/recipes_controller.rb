class RecipesController < ApplicationController

  def index
    render layout: false
  end

  def search
    @query = params[:query]
    @results = EdamamApiWrapper.search_recipes(@query)
    return @results
  end

  def show
    @recipe_uri = params[:uri]
    @recipe = EdamamApiWrapper.show_recipe(@recipe_uri)
    @recipe = @recipe[0]
  end
end
