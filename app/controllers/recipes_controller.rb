class RecipesController < ApplicationController

  def index
    # if params[:term]
    #   term = params[:term]
    # end
    @recipes = EdamamApiWrapper.search(params[:term])
  end
end
