class RecipesController < ApplicationController
  def index
    @recipes = ApiMuncherWrapper.search_recipes(params[:search])
  end

  def show
  end

  def root
  end
end
