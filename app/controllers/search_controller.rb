class SearchController < ApplicationController

  def index


  end

  def new
    # @search = Search.new
  end

  def create #list
    @search = EdamamApiWrapper.find_recipes(params['ingredients'])

    @all_recipes = []
    @search.hits.each do |recipe|
      @all_recipes << Recipe.new(recipe)
    end
  end

  def show
    @recipe
  end
end
