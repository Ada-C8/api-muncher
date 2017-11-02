require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def main; end

  def index
    if params[:q] == ""
      flash[:status] = :failure
      flash[:message] = "You must enter a search term"
      redirect_back(fallback_location: root_path)
    else
      @recipes = EdamamApiWrapper.search(params[:q])
      flash[:status] = :success
      flash[:message] = "successfully searched"
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if @recipe != []
      flash[:status] = :success
      flash[:message] = "Successfully found recipe"
    elsif
      flash[:status] = :failure
      flash[:message] = "You must enter a valid uri id"
      redirect_back(fallback_location: root_path)
    end

  end
end
