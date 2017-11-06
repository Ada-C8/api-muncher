require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  PAGE_ITEMS = 12

  def index
    if params['search']
      @query = params['search']
      @page = (params['page'] || 1).to_i

      recipes = RecipeSearch.search(params['search'], (@page - 1), PAGE_ITEMS, true)
      build_pages(recipes)
    end
  end

  def show
    @recipe = RecipeSearch.find(params["id"])
    return head :not_found unless @recipe
  end

  private

  def build_pages(recipes)
    @less = @page > 1
    @more = recipes.last
    @recipes = recipes.first
  end
end
