class RecipesController < ApplicationController

  def index

    @search = params[:q]
    @from = (params[:from]) ? params[:from].to_i : 0
    @from += 10

    @recipes = EdamamApiWrapper.list_recipes(params[:q], @from )


  end

  def show
    @recipe = EdamamApiWrapper.get_recipe(params[:r])
  end

end
