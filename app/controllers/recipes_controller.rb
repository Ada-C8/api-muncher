class RecipesController < ApplicationController

  def index
    # if params[:term]
    #   term = params[:term]
    # end
    @recipes = EdamamApiWrapper.search(params[:term])
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])

    render_404 unless @recipe
  end
end
