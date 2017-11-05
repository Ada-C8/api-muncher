class RecipesController < ApplicationController

  def root

  end

  def index
    @recipes = ApiWrapper.list_recipes(params[:search])

    if @recipe

    else

    end
  end

  def new

  end

  def show
  end
end
