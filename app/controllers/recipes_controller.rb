require_dependency '../../lib/edamam_api_wrapper'
# require 'pry'

class RecipesController < ApplicationController

  #THIS IS THE SEARCH PAGE WITH QUERY BAR
  def index
  end

  #THIS DISPLAYS THE RESULTS OF WHAT WE FOUND WHEN WE DID THE SEARCH
  def search #recipes_search_path
      @keywords = params['keywords']
      if @keywords.nil?
        redirect_to root_path
      else
        @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)
        @recipes = EdamamApiWrapper.list_recipes(@keywords, 0, 9)
      end
  end

  def search_by_page #search_by_page_path
    @keywords = params['keywords']
    if @keywords == ""
      redirect_to root_path
      flash[:failure] = "You did not enter any keywords. Please enter ingredient keywords into the search bar."
    else
      @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)
      from = params[:from]
      to = params[:to]
      @recipes = EdamamApiWrapper.list_recipes(@keywords, from, to)
      render :search
    end
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params['id'])
  end

end
