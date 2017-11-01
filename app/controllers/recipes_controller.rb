class RecipesController < ApplicationController
  def home # This will give a search bar to find all recipes
  end

  def index # This will show all the results of the search
    @recipes = EdamamApiWrapper.search(params[:q])
    @search_request = params[:q]
  end

  def show
    # Call method to find the recipe using the uri r insetad of q
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
  end
end
