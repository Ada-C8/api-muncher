class RecipesController < ApplicationController

  def root
    
  end

  def search
    @recipes = EdamamApiWrapper.search_recipes(params[:query])
  end

  def create
  end
end
