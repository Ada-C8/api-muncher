require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'
require 'pry'

class RecipesController < ApplicationController


  #THIS IS THE SEARCH PAGE WITH QUERY BAR
  def index

  end

  #THIS DISPLAYS THE RESULTS OF WHAT WE FOUND WHEN WE DID THE SEARCH
  def search

    @keywords = params['keywords']
    if @keywords.nil?
      redirect_to root_path
    else
      @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)

      @recipes = EdamamApiWrapper.list_recipes(@keywords, params['from'], params['to'])



    end
  end

  def search_by_page

    @keywords = "lemon tart"
    if @keywords.nil?
      redirect_to root_path
    else
      params[:this_is_not_in_the_url] = "Maybe there's another way"
      from = params[:from]
      to = params[:to]
      @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)

      @recipes = EdamamApiWrapper.list_recipes(@keywords, from, to)



    end

    render :search
  end

  def show
    #@recipe = EdamamApiWrapper.show_recipe(params)
    # @recipe = params['recipe']
    # @uri_id = find_recipe_id(@recipe.uri)
    @recipe = EdamamApiWrapper.show_recipe(params['id'])
    # @recipe.id = @recipe.

  end

end
