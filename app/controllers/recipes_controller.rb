class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
  end

  def show
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
    @recipe = @recipes.select { |recipe| URI.encode(recipe.url) == params[:url]}
  end

end
