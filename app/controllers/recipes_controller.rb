class RecipesController < ApplicationController
  def root
    # I don't think this needs anything currently.
  end

  def index
    @recipes = EdamamApiWrapper.list_recipes(params[:search_term])
    @search_term = params[:search_term]
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:recipe_uri])
    # https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
  end
end
