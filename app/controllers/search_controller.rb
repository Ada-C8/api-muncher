class SearchController < ApplicationController

  def index

  end

  def create
    if params['ingredients']
      @keywords = params['ingredients']
    else
      redirect_to root_path
    end

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
    @search.hits.each do |recipe|
      @all_recipes << Recipe.new(recipe['recipe'])
    end
  end

  def show_recipe
    response = EdamamApiWrapper.show_recipe(params['uri'])
    if response != nil
      @recipe = Recipe.new(response[0])
    else
      flash.now[:failure] = "There are no recipes matching that query"
      redirect_back(fallback_location: root_path)
    end
  end
end
