class RecipesController < ApplicationController
  def index
    if params["id"]
      if params["page_id"]
        @page = params["page_id"]
        @recipes = RecipeSearch.search(params["id"])
      else
        @recipes = RecipeSearch.search(params["id"])
      end
    end
  end

  def search
    if params["search"]
      @query = params["search"]
      redirect_to recipe_results_path(@query)
    end
  end
end
