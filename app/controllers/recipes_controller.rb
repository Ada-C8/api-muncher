require_dependency '../../lib/muncher_api_wrapper'
require_dependency '../../lib/recipe'


class RecipesController < ApplicationController
  def index

    @recipes_count = MuncherApiWrapper.find_recipes(params[:word], params[:page])
    @recipes = @recipes_count[0]
    @count = @recipes_count[1]
    if @recipes == [ ]
      flash[:status] =  :not_found
      flash[:message] = "No hay recetas con la palabra #{params[:word]}"
      redirect_back fallback_location: root_path
    else
      flash[:status] = :success
      flash[:message] = "Estas son las recetas encontradas"
    end

  end

  def show
    @recipe = MuncherApiWrapper.one_recipe(params[:id])
    unless @recipe
      head :not_found
    end
  end
end
