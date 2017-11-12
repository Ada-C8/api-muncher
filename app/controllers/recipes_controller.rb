require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'
require 'will_paginate/array'

class RecipesController < ApplicationController
  def root
  end

  def index
    @search_term = params[:search_term]
    api_results = EdamamApiWrapper.list_recipes(@search_term)

    if api_results.empty?
      flash[:status] = :failure
      flash[:message] = "Your search for '#{@search_term}' did not match any recipes. Try again!"
      redirect_to root_path
    else
      @recipes = api_results.paginate(:page => params[:page], :per_page => 10)
      return @recipes
    end
  end

  def show
    @recipe = EdamamApiWrapper.show_recipe(params[:recipe_uri])
    # https://api.edamam.com/search?r=http://www.edamam.com/ontologies/edamam.owl%23recipe_637913ec61d9da69eb451818c3293df2
  end
end
