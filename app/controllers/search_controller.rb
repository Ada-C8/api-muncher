class SearchController < ApplicationController

  def index


  end

  def create
    @keywords = params['ingredients']

    if (params[:page].to_i == 1 || params[:page].to_i == 0)
      @search = EdamamApiWrapper.find_recipes(@keywords)
      @page = 1
    else
      @page = params[:page].to_i
      from = (@page * 10) - 10
      to = from + 9
      @search = EdamamApiWrapper.find_recipes(@keywords, from, to)
    end

    @all_recipes = []
    if @search == []
      flash.now[:failure] = "There are no recipes matching that query"
    else
      @search.hits.each do |recipe|
        @all_recipes << Recipe.new(recipe['recipe'])
      end
    end
  end

  def show_recipe
    response = EdamamApiWrapper.show_recipe(params['uri'])
    @recipe = Recipe.new(response[0])
  end
end
