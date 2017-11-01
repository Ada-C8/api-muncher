class RecipesController < ApplicationController

def index
  if params[:search]
    @recipes = RecipeApiWrapper.search(params[:search])
    #If search doesn't return anything it will return an empty array - handle in the view sending a message about that
  else
    @recipes = nil
  end
end

def show
  @recipe = RecipeApiWrapper.find(params[:id])
end

end
