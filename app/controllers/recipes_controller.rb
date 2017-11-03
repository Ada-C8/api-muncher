require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController
  def home
    @home_page = true
  end

  def index
    @home_page = false

    @recipes = EdamamApiWrapper.query(params[:search]).paginate(page: params[:page], per_page: 10)
    if @recipes.length == 0
      flash[:message] = "No search results found"
      redirect_to root_path
    end
  end

  def show
    @home_page = false

    @recipe = EdamamApiWrapper.find_recipe(params[:uri])
    unless @recipe
      render_404
    end
  end

end
