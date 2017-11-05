class RecipesController < ApplicationController

  def index
    if params[:query]
      @recipes = EdamamApiWrapper.search(params[:query])
    else
      redirect_to root_path
    end
  end

  def show
    if params[:uri]
      @recipe = EdamamApiWrapper.find_recipe(params[:uri])
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def task_params
    params.require(:recipe).permit(:query)
  end
end
