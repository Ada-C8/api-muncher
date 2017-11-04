require_dependency '/../lib/edamam_api_wrapper'
require_dependency '/../lib/recipe'

class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = EdamamApiWrapper.search_recipes(params["search"])
    if @recipes.empty?
      flash[:result_text] = "No results match your search."
      redirect_to root_path
    else
      @results_page = @recipes.paginate(:page => params[:page], :per_page => 10)
    end
  end

  # def new
  #   @recipes = EdamamApiWrapper.search_recipes(search)
  #   @recipes.each do |recipe|
  #
  #    if recipe.uri == params["recipe"]
  #      @recipe = recipe
  #    end
  #  end
  # end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])

  end









end
