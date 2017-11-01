class RecipesController < ApplicationController
  # TODO: pass in the proper parameter
  def index
    @recipes = EdamamApiWrapper.list_recipes("chicken")
  end
end
