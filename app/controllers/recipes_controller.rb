require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def home

  end

  def index
    @recipes = EdamamApiWrapper.query(params[:search])
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:uri])
    # @recipe = @recipes.select.each do |recipe|
    #   recipe.link == params[:link]
    # end
  end

  def new
  end
end
