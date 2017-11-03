require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def search_form
    @random = ["water", "sourdough bread", "tacos", "pizza", "chocolate chip cookies", "liver", "garbage"].sample
    @world = EdamamApiWrapper.world_food
    @protein = EdamamApiWrapper.protein
    @vegetables = EdamamApiWrapper.vegetables
    @various = EdamamApiWrapper.various
    @desserts = EdamamApiWrapper.desserts
    @drinks = EdamamApiWrapper.drinks
    @all = [@world, @protein, @vegetables, @various, @desserts, @drinks]
  end

  def index
    @recipes = EdamamApiWrapper.search_recipes(params[:search]).paginate(:page => params[:page], :per_page => 9)
  end

  def show
    @recipe = EdamamApiWrapper.recipe_details(params[:uri])
  end
end
