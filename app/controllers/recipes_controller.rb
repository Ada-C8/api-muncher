#require "#{Rails.root}/lib/recipes.rb"

class RecipesController < ApplicationController
  def index
  end

  def results
    @results = RecipeApiWrapper.recipe_query(params[:q])
  end

  def show
    @recipe = RecipeApiWrapper.recipe_details(params[:uri])
  end
end
