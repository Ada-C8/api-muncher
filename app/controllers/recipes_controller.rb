require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index

    @recipes = EdamamApiWrapper.list_recipes(params[:search_word]).paginate(:page => params[:page], :per_page => 9)

    if @recipes.empty?
      flash[:status] = :error
      flash[:result] = "Please try again, no results found for #{params[:search_word]}"
      redirect_to root_path
    end
  end

  def show

    @recipe = EdamamApiWrapper.show_recipe(params[:id])
    render_404 unless @recipe

  end
end
