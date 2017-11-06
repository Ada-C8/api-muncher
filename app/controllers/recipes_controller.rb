require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def root

  end

  def index
    @from = params[:from] ? params[:from] : 0
    @query = params[:query]
    @recipes = EdamamApiWrapper.search(@query)

    if @query[/[^A-Za-z0-9_ -]+/]
      flash[:status] = :failure
      flash[:message] = "Invalid input: please try again without symobls."

      redirect_back(fallback_location: root_path)
    else
      if @recipes.empty?
        render :no_match, status: :bad_request
      end
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:recipe_id])

    unless @recipe
      head :not_found
    end
  end

  def no_match

  end

end
