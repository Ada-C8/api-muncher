class RecipesController < ApplicationController

  def index
  end

  def results
    r1 = Recipe.new("http://google.com/1", "First Fake data for: " + params[:q])
    r2 = Recipe.new("http://google.com/2", "Second Fake data for " + params[:q])
    @recipes = [r1, r2]
  end

  def show
    Recipe r1 = Recipe.new("http://google.com/1", "First Fake data for " + params[:id])
  end

end
