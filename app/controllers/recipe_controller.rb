class RecipeController < ApplicationController
  def list_search
    @recipes = EdamamApiWrapper.search(params["q"]).paginate(page: params[:page], per_page: 10)

    if @recipes.length == 0
      flash[:message] = "No search results found"
      redirect_to root_path
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params["recipe"])
  end
end
