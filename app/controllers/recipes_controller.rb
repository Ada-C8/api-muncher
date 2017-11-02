class RecipesController < ApplicationController
  def home
  end

  def index
    #returns a list of searched criteria
    query = params["search"]
    # @recipes = EdamamApiWrapper.search(query).paginate(page: params[:page], per_page: 10)
    @recipes = EdamamApiWrapper.search(query)
  end

  def show
    #shows an individual recipe's information
    @recipe = EdamamApiWrapper.view_recipe(params["uri"])
  end

end
