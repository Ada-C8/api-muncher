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
      # if params['from']
      #   @recipes = EdamamApiWrapper.list_recipes(@keywords, 0, 9)
      # else
        @recipes = EdamamApiWrapper.list_recipes(@keywords, 0, 9)
      # end
    end
  end

  def search_by_page
    @keywords = params['keywords']
    if @keywords == ""
      redirect_to root_path
      #add flash message maybe
    else
      @number_of_recipes = EdamamApiWrapper.find_number_of_recipes(@keywords)

      if @number_of_recipes > 100
        @greater_than_100 = true
        @number_of_recipes_on_last_page = 10
      else
        @greater_than_100 = false
        @number_of_recipes_on_last_page = @number_of_recipes%10
      end

      from = params[:from]
      to = params[:to]
      @recipes = EdamamApiWrapper.list_recipes(@keywords, from, to)
      render :search
    end
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params['id'])
  end

  private

  # def find_number_of_recipes_on_last_page


end
