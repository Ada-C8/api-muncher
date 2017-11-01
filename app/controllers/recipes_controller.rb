require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def search_form
  end

  def search
    @recipes = EdamamApiWrapper.search_recipes(params[:search])
  end

  def show
  end
end
