require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController


  #THIS IS THE SEARCH PAGE WITH QUERY BAR
  def index

  end

  #THIS DISPLAYS THE RESULTS OF WHAT WE FOUND WHEN WE DID THE SEARCH
  def search
    @keywords = params['keywords']
    if @keywords.empty?
      redirect_to root_path
    else
      #Will eventually modify list_recipes method to take 3 parameters (keywords, from, to) for receiving recipes by page.
      @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)
      @recipes = EdamamApiWrapper.list_recipes(@keywords, params['from'], params['to'])
    end
  end

  def show
    #@recipe = EdamamApiWrapper.show_recipe(params)
    # @recipe = params['recipe']
    # @uri_id = find_recipe_id(@recipe.uri)
    @recipe = EdamamApiWrapper.show_recipe(params['id'])
    # @recipe.id = @recipe.

  end

end
