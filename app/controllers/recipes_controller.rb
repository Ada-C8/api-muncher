class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show

    @recipe = EdamamApiWrapper.show_recipe(params[:search], params[:url])

    if !@recipe
      render :home, status: :not_found
      flash[:status] = :error
      flash[:result_text] = "Could not find recipe."
    end
  end
end
