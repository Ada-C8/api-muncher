class RecipesController < ApplicationController
  PAGE_ITEMS = 12

  def index
    if params["id"]
      @query = params["id"]
      @page = (params["page"] || 1).to_i

      recipes = RecipeSearch.search(params["id"], (@page - 1), PAGE_ITEMS, true)
      build_pages(recipes)
    end
  end

  def show
    @recipe = RecipeSearch.find(params["id"])
  end

  def search
    if params["search"]
      @query = params["search"]
      redirect_to recipe_results_path(@query)
    end
  end

  private

  def build_pages(recipes)
    @less = @page > 1
    @more = recipes.length > PAGE_ITEMS
    @recipes = recipes[0...PAGE_ITEMS]
  end
end
