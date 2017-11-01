class RecipesController < ApplicationController
  def index
    if params["search"]
      @query = params["search"]
      @recipes = RecipeSearch.search(@query)   
    end
  end
end
