#require "#{Rails.root}/lib/recipes.rb"

class RecipesController < ApplicationController
  def index
  end

  def results
    @results = RecipeApiWrapper.recipe_query(params[:q])
  end

  def show
    @uri = params[:uri] + "." + params[:format].gsub(/#/,'%23')
    @recpie = RecipeApiWrapper.recipe_details(@uri)
  end
end
