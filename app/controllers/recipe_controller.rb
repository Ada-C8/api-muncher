class RecipeController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.search("chocolate",3)
  end

  def show
  end
end
