require 'will_paginate/array'


class RecipeController < ApplicationController

   def root
    #  session[:page_number] = nil
   end

  def index
    puts "these are the #{params}"
    @query = params[:query]
    @recipes = EdemamApiWrapper.list_recipes(@query).paginate(:page => params[:page], per_page: 10)
    if @recipes == []
      flash.now[:status] = "failure"
      flash.now[:message] = "No recipes could be found for #{@query}"
      render :root
    end
    #Post.paginate :page => params[:page]
    #@recipes.page(params[:page]).per_page(2)
    # if session[:page_number] == nil
    #   session[:page_number] = 0
    # else
    #   session[:page_number] += 1
    # end
  end

  def show
    @recipe = EdemamApiWrapper.find_a_recipe(params["uri"])
  end


end
