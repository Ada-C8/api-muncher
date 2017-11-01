class RecipesController < ApplicationController

  def search
  end

  def index
    @search = params[:search]
    @recipes = FoodApiWrapper.find_recipes(@search)
    if @recipes.length == 0
      flash[:result_text] = "No Results Found"
    end
  end

  def show
    @uri = params[:uri]
    @recipe = FoodApiWrapper.show_recipe(@uri)
    unless @recipe
      render_404
    end
  end
end
