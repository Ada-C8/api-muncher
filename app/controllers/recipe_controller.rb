class RecipeController < ApplicationController

  def index
    @recipes = EdamamApiWrapper.search_recipes(search)
  end

  def new
    @recipes = EdamamApiWrapper.search_recipes(search)
    @recipes.each do |recipe|

     if recipe.uri == params["recipe"]
       @recipe = recipe
     end
   end
  end

  def show
    @recipes = EdamamApiWrapper.search_recipes
  end









end
