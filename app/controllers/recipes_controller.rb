class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.search_recipes
  end

  def show
  end
end
