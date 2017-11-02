class RecipesController < ApplicationController

  def index
  end

  def results
    @recipes = EdamamApiMuncher.search(params[:q], params[:from], params[:to])
  end

  def show
    Recipe r1 = Recipe.new("http://google.com/1", "First Fake data for " + params[:id])
  end

end
