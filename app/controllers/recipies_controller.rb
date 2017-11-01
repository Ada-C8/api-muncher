class RecipiesController < ApplicationController
  def root
  end # root

  def index
    @recipies = EdamamApiWrapper.get_recipies(params[:search_term])
  end # index

  def show
    # use the uri to do a search for a specific recipe from the api
    # have to encode the uri to get rid of some weird characters in it
    # will have to make another method in EdamamApiWrapper to call here!
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])
  end # show
end
