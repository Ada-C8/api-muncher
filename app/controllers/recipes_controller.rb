require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'


class RecipesController < ApplicationController

  def index
    # @recipes = EdamamApiWrapper.list_recipes(params[:search])

    if (params[:search])
      my_array_object = EdamamApiWrapper.list_recipes(params[:search])
      @recipes =  Kaminari.paginate_array(my_array_object).page(params[:page]).per(10)
    else
      redirect_to root_path
    end
  end

  def show
    begin
      @recipe = EdamamApiWrapper.show_recipe(params[:uri])

      if @recipe # good
        render :show, status: 200 #:success
      else
        flash[:error] = "recipe not found"
        redirect_to root_path
      end
    rescue
      flash[:error] = "recipe not found"
      redirect_to root_path
    end
  end


end
