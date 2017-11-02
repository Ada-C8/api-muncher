class RecipesController < ApplicationController
  def welcome
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search_term])
  end

  def show  
  end

end
