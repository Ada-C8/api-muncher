class RecipesController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.list_channels(search)
  end

end
