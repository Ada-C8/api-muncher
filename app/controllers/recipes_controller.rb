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
  end

  def new
  end
end
