class RecipesController < ApplicationController

  def search
  end

  def index
    @search = params[:search]
    @recipes = FoodApiWrapper.find_recipes(@search)
  end

  def show
    @recipe = params[:id]
  end
end
