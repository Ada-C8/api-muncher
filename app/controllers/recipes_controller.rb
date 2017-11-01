class RecipesController < ApplicationController
  # TODO: pass in the proper parameter
  @recipes = ApiMuncherWrapper.list_recipes("chicken")
end
