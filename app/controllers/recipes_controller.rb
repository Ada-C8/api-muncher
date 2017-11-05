class RecipesController < ApplicationController

  def search
    @recipeace = FoodApiWrapper.find_recipes("peace").sample
  end

  def index
    @search = params[:search]
    @recipes = FoodApiWrapper.find_recipes(@search).paginate(:page => params[:page], :per_page => 9)
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
