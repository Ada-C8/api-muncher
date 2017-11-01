class RecipesController < ApplicationController
  def main; end

  def index
    if params[:q] == ""
      flash[:status] = :failure
      flash[:message] = "You must enter a search term"
      redirect_back(fallback_location: root_path)
    else
      @recipes = EdamamApiWrapper.search(params[:q])
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
  end
end
