class RecipesController < ApplicationController
  def home
  end

  def index
    #returns a list of searched criteria
    query = params["search"]
    @recipes = EdamamApiWrapper.search(query)
  end

  def show
    #shows an individual recipe's information
  end
end
