require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipeController < ApplicationController
  def list_search
    @recipes = EdamamApiWrapper.search(params["q"]).paginate(page: params[:page], per_page: 12)

    if @recipes.length == 0
      flash[:status] = :failure
      flash[:message] = "No search results found"
      redirect_back fallback_location: root_path, status: :see_other
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params["recipe"])

    unless @recipe
      flash[:status] = :failure
      flash[:message] = "That recipe does not exist"
      redirect_back fallback_location: root_path, status: :see_other
    end
  end
end
