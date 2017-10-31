class RecipesController < ApplicationController
  def index
    if params["search"]
      @recipes = RecipeSearch.search(params["search"])      
    end
  end
end
