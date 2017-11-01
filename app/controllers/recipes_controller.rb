require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def root; end

  def index
    @recipes = EdamamApiWrapper.search(params[:q])
    @search = params[:q].upcase
  end

  def show
    # uri = params[:id]
    # uri.gsub(/%2F/, "/")
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
  end

end
