require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.search_recipes()
  end

  def show
  end
end
