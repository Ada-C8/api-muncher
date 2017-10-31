class RecipeController < ApplicationController
  def home # This will give a search bar to find all recipes
  end

  #TODO: Rename this search controller to recipe controller
  def index # This will show all the results of the search
    @recipes = EdamamApiWrapper.search(params[:something_goes_here_from_the_form])
  end

  def show
    @recipe = params[:passinanidofsomesorthere]
  end
end
