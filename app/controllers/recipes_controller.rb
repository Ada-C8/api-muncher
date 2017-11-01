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
  end

end
