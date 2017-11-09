require_dependency '../../lib/muncher_api_wrapper'
require_dependency '../../lib/recipe'


class RecipesController < ApplicationController
  def index

    @respond = MuncherApiWrapper.find_recipes(params[:word], params[:page])
    @recipes = @respond[0]
    @count = @respond[1]
    if @recipes == []
      # render :file => "/public/404.html",  :status => 404
      flash.now[:status] = :not_found
      flash.now[:message] = "No hay recetas con la palabra #{params[:word]}"
      # redirect_back fallback_location: root_path
    else
      flash.now[:status] = :success
      flash.now[:message] = "Estas son las recetas encontradas"
    end

    if params[:page].to_i < 1
      # flash[:status] =  :not_found
      # flash[:message] = "No hay información disponible en esta página"
      #redirect_back fallback_location: root_path
      head :not_found
    end
  end

  def show
    @recipe = MuncherApiWrapper.one_recipe(params[:id])

    if @recipe == []
      head :not_found

    end


  end
end
