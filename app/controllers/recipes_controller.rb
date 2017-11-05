require 'will_paginate/array'

class RecipesController < ApplicationController
  def home

  end

  def index
    #returns a list of searched criteria
    query = params["search"]

    if params["search"] == ""
      flash[:status] = :error
      flash[:result_text] = "Please enter a food you'd like to eat"
      redirect_to root_path
    else
      @recipes = EdamamApiWrapper.search(query).paginate(page: params[:page], per_page: 10)
    end
  end

  def show
    #shows an individual recipe's information
    @recipe = EdamamApiWrapper.view_recipe(params["uri"])
  end

end
