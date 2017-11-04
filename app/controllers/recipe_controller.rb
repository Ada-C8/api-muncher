class RecipeController < ApplicationController
  def home

  end

  def index
    # @recipes = Recipe.all
    if params[:search]
      results = EdamamApiWrapper.search_recipe_results(params[:search])
      @recipes = results.paginate(:page => params[:page], :per_page => 10)
    else
      flash[:failure] = "No search term entered"
      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:uri])

    if  !@recipe
      redirect_to root_path
    end
  end

end
