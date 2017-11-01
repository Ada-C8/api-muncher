class RecipesController < ApplicationController
  def home
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:ingredient])
    @count = EdamamApiWrapper.num_recipes(params[:ingredient])
  end

  def show
     @recipe = EdamamApiWrapper.find_recipe(params[:uri])
  end
end
