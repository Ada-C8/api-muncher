class RecipeController < ApplicationController

  def index

  end

  def show
    @recpie = RecpieApiWrapper.recipe_details(params[:uri])
  end

  def result
    @results = RecpieApiWrapper.recipe_query(params[:q])
  end
end
