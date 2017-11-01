class RecipesController < ApplicationController
  # TODO: pass in the proper parameter
  @recipes = EdamamApiWrapper.list_recipes("chicken")
end
