require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def search
  end

  def index
    @recipes = EdamamApiWrapper.find_recipes(params['keywords'])
    @keywords = params['keywords']
  end

  def show
  end

end
