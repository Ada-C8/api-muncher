require 'will_paginate/array'

class RecipesController < ApplicationController
  def index
    @recipes = ApiMuncherWrapper.search_recipes(params[:search]).paginate(:page => params[:page], :per_page => 10)
    if session[:recent_searches]
      session[:recent_searches][params[:search]] = @recipes[0] ? @recipes[0].image : nil
    else
      session[:recent_searches] = {params[:search] => @recipes[0] ? @recipes[0].image : nil}
    end
  end

  def show
    @recipe = ApiMuncherWrapper.find_recipes(params[:uri])
    render_404 unless @recipe
  end

  def root
  end
end
