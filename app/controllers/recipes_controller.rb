class RecipesController < ApplicationController

  def root; end

  def index
    recipes = EdamamApiWrapper.search_recipes(params[:query])
    @recipes = recipes.paginate(page: params[:page], per_page: 9)
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:id])
    unless @recipe
      return head :not_found
    end
  end
end
