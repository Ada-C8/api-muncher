require 'json/ext'
require 'will_paginate/array'

class RecipesController < ApplicationController

  def home
  end

  def index
    @search_string = params[:search]

    if @search_string.blank?
      flash[:error] = "Please enter a search term."
      redirect_to root_path
      return @recipes = nil
    else
      return @recipes = EdamamApiWrapper.list_recipes(@search_string).paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])

    if !@recipe
      return render_404
    end
  end

end
