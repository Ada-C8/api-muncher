require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    render layout: false
  end

  def search
    @query = params[:query]
    @results = EdamamApiWrapper.search_recipes(@query)
    if @results['hits'] != []
      @results = @results['hits']
      @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)
      return @results
    else
      return @results = nil
    end
  end

  def show
    @recipe_uri = params[:uri]
    @recipe = EdamamApiWrapper.show_recipe(@recipe_uri)
  end
end
