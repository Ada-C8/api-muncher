class RecipesController < ApplicationController
  def index
    @recipes = MuncherApiWrapper.find_recipes(params[:word])
  end
end
