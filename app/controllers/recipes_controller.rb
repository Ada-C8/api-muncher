class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search])
  end

  def show
  end

  # def new
  # end
  #
  # def create
  # end

end
