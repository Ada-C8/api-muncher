class RecipesController < ApplicationController
  def search
  end

  def index
    # if invalid, route back to search render 404
    if params[:query].blank?
      # flash[err] query iz blank
      redirect_to root_path
    else
      # check the string, dsiplay all recipes if valid
      query = params[:query]
      # search using API Wrapper
      @recipes = EdamamApiWrapper.search(query)
    end
  end

  def show
    @recipe = EdamamApiWrapper.search(params[:id])[0]
    if @recipe.blank?
      # flash[err] query iz blank
      redirect_to root_path
    end
  end
end
