class SearchController < ApplicationController

  def index

  end

  def new
    # @search = Search.new
  end

  def create
    @search = EdamamApiWrapper.find_recipes(params['ingredients'])
    redirect_to search_path(@search)
  end

  def show
    @search = params['search']
  end
end
