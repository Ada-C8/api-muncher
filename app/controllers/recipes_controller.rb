require 'edamam_api_wrapper'
class RecipesController < ApplicationController

  def index
    # @recipes = EdamamApiWrapper.search(params[:q])
  end

  def show
    @recipe = EdamamApiWrapper.create_recipe(params[:recipe_uri])
  end

  def search
    response = EdamamApiWrapper.search(params[:q])
    @recipes = EdamamApiWrapper.get_results_from_response(response)
    render search_path
  end

  private

end
