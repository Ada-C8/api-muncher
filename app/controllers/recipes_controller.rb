require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    render layout: false
  end

  def search
    @query = params[:query]
    @results = EdamamApiWrapper.search_recipes(@query)
    @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)

    return @results
  end

  def show
    @recipe_uri = params[:uri]
    @recipe = EdamamApiWrapper.show_recipe(@recipe_uri)
    @recipe = @recipe[0]
  end
end
