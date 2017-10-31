require 'will_paginate/array'

class RecipesController < ApplicationController
  def index
    @recipes = ApiMuncherWrapper.search_recipes(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @recipe = ApiMuncherWrapper.find_recipes(params[:uri])
  end

  def root
  end
end
