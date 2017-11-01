class SearchController < ApplicationController

  def index


  end

  def new

  end

  def create #list

    if (params[:page].to_i == 1)
      @search = EdamamApiWrapper.find_recipes(params['ingredients'])
      @page = 1
    else
      @page = params[:page].to_i
      from = (@page * 10) - 10
      to = from + 9
      @search = EdamamApiWrapper.find_recipes(params['ingredients'], from, to)
    end

    @all_recipes = []
    @search.hits.each do |recipe|
      @all_recipes << Recipe.new(recipe['recipe'])
    end
  end

  def show
    response = EdamamApiWrapper.show_recipe(params['uri'])
    @recipe = Recipe.new(response[0])
  end
end
