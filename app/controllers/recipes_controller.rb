class RecipesController < ApplicationController
  def index
    if params["search"]
      @recipes = RecipeSearchWrapper.search(params["search"])      
    end
  end
end
