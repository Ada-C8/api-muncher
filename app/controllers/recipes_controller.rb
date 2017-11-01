class RecipesController < ApplicationController

  def index
    render layout: false
  end

  def search
    @query = params[:query]
    @results = EdamamApiWrapper.search_recipes(@query)
    # @results = @results.limit(10).page(params[:page])
    @results = Kaminari.paginate_array(@results.first(10)).page(params[:page])

    # @songs = Song.limit(10).page(params[:page])
    # @songs = Kaminari.paginate_array(Song.first(10)).page(params[:page])
    return @results
  end

  def show
    @recipe_uri = params[:uri]
    @recipe = EdamamApiWrapper.show_recipe(@recipe_uri)
    @recipe = @recipe[0]
  end
end
