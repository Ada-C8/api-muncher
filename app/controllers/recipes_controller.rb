require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'
require 'will_paginate/array'

class RecipesController < ApplicationController
  before_action :disable_header_search, only: [:main]

  def main; end

  def index
    if params[:q] == ""
      flash[:status] = :failure
      flash[:message] = "You must enter a search term"
      redirect_back(fallback_location: root_path)
    else
      @recipes = EdamamApiWrapper.search(params[:q])
      @recipes = @recipes.paginate(:page => params[:page], :per_page => 10)
      flash[:status] = :success
      flash[:message] = "successfully searched"
    end
  end

  def show
    @recipe = EdamamApiWrapper.find_recipe(params[:id])
    if @recipe != []
      flash[:status] = :success
      flash[:message] = "Successfully found recipe"
    elsif
      flash[:status] = :failure
      flash[:message] = "You must enter a valid uri id"
      redirect_back(fallback_location: root_path)
    end

  end
end
