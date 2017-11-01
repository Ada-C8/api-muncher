class RecipesController < ApplicationController

  def search
  end

  def index
    @search = params[:search]
    @recipes = FoodApiWrapper.find_recipes(@search)
  end

  def show
    @uri = params[:uri]
    @recipe = FoodApiWrapper.show_recipe(@uri)
  end
end
