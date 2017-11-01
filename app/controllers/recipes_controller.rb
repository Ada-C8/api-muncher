class RecipesController < ApplicationController
  PAGE_ITEMS = 12

  def index
    if params["id"]
      @query = params["id"]
      @page = params["page_id"] || 1
      p @query, @page

      recipes = RecipeSearch.search(params["id"], (@page.to_i - 1), (PAGE_ITEMS + 1))
      @less = @page != 0
      @more = recipes.length > PAGE_ITEMS
      @recipes = recipes[0...PAGE_ITEMS]
    end
  end

  def search
    if params["search"]
      @query = params["search"]
      redirect_to recipe_results_path(@query)
    end
  end
end
