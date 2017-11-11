require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def root ;
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search_term])
    @search_term = params[:search_term]

    # if results.empty?
      # flash[:status] = :failure
      # flash[:message] = "Sorry, your search term '#{params[:search_term]}' didn't match any recipes. Please try again."
      # redirect_to root_path
    # else

  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:recipe_uri])
    # https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
  end
end
