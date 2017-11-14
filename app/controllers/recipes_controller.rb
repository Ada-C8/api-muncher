require_dependency '../../lib/edamam_api_muncher'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index # Main page that we search for food
  end

  def results # Gives all results for the search
    if params[:q] == ""
      flash[:status] = :failure
      flash[:message] = "Please enter a search word"
      redirect_back(fallback_location: root_path)
    else
      @recipes = EdamamApiMuncher.search(params[:q], params[:from], params[:to])
      flash[:status] = :success
      flash[:message] = "Search is successful"
    end
  end

  def show # details page
    @recipe = EdamamApiMuncher.find(params[:id])
    if @recipe
      flash[:status] = :success
      flash[:message] = "Success, recipe has been found"
    else
      flash[:status] = :failure
      flash[:message] = "Please enter a valid uri id"
      redirect_back(fallback_location: root_path)
    end
  end

end
