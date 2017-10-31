class RecipesController < ApplicationController
  def home

  end

  def index
    @recipes = EdamamApiWrapper.query(params[:search])
  end

  def show
  end

  def new
  end
end
