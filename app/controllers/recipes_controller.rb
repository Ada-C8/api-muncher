require 'json/ext'
require 'will_paginate/array'

class RecipesController < ApplicationController

  def home
  end

  def index
    @search_string = params[:search]

    if @search_string
      return @recipes = EdamamApiWrapper.list_recipes(@search_string).paginate(page: params[:page], per_page: 10)
    elsif @recipes == nil || @recipes == ""
      return @recipes = nil
    end
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:uri])
  end

end
