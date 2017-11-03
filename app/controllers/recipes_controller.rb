class RecipesController < ApplicationController

  def index
    if params[:query]
      @recipes = EdamamApiWrapper.search(params[:query])
    else
      redirect_to root_path
    end
  end

  def show
  end

  def task_params
    params.require(:recipe).permit(:query)
  end
end
