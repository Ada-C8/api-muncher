class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
  end

  def show
    recipes = EdamamApiWrapper.list_recipes(params[:search])
    recipe_array = recipes.select { |recipe| URI.encode(recipe.url) == params[:url]}
    @recipe = recipe_array[0]
    if !@recipe
      render :home, status: :not_found
      flash[:status] = :error
      flash[:result_text] = "Could not find recipe."
    end
  end

end
