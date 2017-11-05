class RecipesController < ApplicationController

  def root

  end

  def index
    @recipes = ApiWrapper.list_recipes(params[:search])
  end

  def new

  end

  def show
  end
end
