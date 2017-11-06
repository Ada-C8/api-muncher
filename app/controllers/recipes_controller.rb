class RecipesController < ApplicationController

  def root

  end

  def index
    @query = params[:search]

    if params[:search]
      # source for pagination https://hackhands.com/pagination-rails-will_paginate-gem/

      # to paginate on an array source, https://stackoverflow.com/questions/4352895/ruby-on-rails-will-paginate-an-array
      @recipes = ApiWrapper.list_recipes(params[:search]).paginate(:page => params[:page], :per_page => 10)
    else
      flash[:status] = :failure
      flash[:message] = "Invalid search term, please search for something else"
    end
  end

  def new

  end

  def show
    @recipe = ApiWrapper.find_recipe(params[:id])

    unless @recipe
      head :not_found
    end
  end
end
