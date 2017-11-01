class RecipesController < ApplicationController
  def index
    if params["id"]
      @recipes = RecipeSearch.search(params["id"])
    end
  end

  def search
    if params["search"]
      @query = params["search"]
      redirect_to recipe_results_path(@query)
    end
  end
end
