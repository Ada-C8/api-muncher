class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
  end

  def show
    @recipe = @recipes.select { |recipe| recipe.url == params[:url]}
  end

end
