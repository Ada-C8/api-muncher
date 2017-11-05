class RecipesController < ApplicationController

  def root

  end

  def index
    @query = params[:search]
    
    if params[:search]
      @recipes = ApiWrapper.list_recipes(params[:search])
    else
      flash[:status] = :failure
      flash[:message] = "Invalid search term, please search for something else"
    end
  end

  def new

  end

  def show
  end
end
