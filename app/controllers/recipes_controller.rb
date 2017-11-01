class RecipesController < ApplicationController

  def search
  end

  def create
    #this is where i can make a call to "create" a new search??
  end

  def index
    @search = params[:search]
    @recipes = FoodApiWrapper.find_recipes(@search)
  end

  def show
    @recipe = uri
  end
end
