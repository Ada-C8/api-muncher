class RecipesController < ApplicationController
  def root

  end

  def index
    @query = params[:query]
    @recipes = EdamamApiWrapper.search(@query)
  end

  def show
    @recipe = params[:id]
  end

end
