class RecipeController < ApplicationController
  def home

  end

  def index
    if params[:search] == "" || !params[:search]
      flash[:failure] = "No search term entered"
      redirect_to root_path
    elsif params[:search]
      results = EdamamApiWrapper.search_recipe_results(params[:search])
      @recipes = results.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def show
    if !params[:uri]
      @recipe = nil
    else
      @recipe = EdamamApiWrapper.find_recipe(params[:uri])
    end

    if  !@recipe
      flash[:failure] = "This recipe does not exist"
      redirect_to root_path
    end
  end

end
