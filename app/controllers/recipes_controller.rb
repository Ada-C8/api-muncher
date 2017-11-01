require 'edamam_api_wrapper'
class RecipesController < ApplicationController
  def search
    response = EdamamApiWrapper.search(params[:q])
    @recipes = EdamamApiWrapper.get_results_from_response(response)
    render search_path
  end
end
