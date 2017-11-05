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
      # health_search = []
      # if params[:peanut_free] == "1"
      #   health_search << "peanut-free"
      # end
      # if params[:tree_nut_free] == "1"
      #   health_search << "tree-nut-free"
      # end
      # health_search = health_selections
      puts "health and diet selections #{health_diet_selections}"
      @recipes = EdamamApiWrapper.search(params[:q], health_diet_selections)
      @recipes = @recipes.paginate(:page => params[:page], :per_page => 12)
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

  private
  # Edamam free version of recipe search API can only use 10 specific filters:
  # the 4 following diet labels: balanced, high-protein, low-fat, low-carb
  # and the 6 following health labels: vegan, vegetarian, sugar-conscious, peanut-free, tree-nut-free, and alcohol-free
  def health_diet_selections
    health_diet_search = { health: [], diet: []}
    if params[:sugar_conscious] == "1"
      health_diet_search[:health] << "sugar-conscious"
    end
    if params[:peanut_free] == "1"
      health_diet_search[:health] << "peanut-free"
    end
    if params[:tree_nut_free] == "1"
      health_diet_search[:health] << "tree-nut-free"
    end
    if params[:alcohol_free] == "1"
      health_diet_search[:health] << "alcohol-free"
    end
    if params[:vegan] == "1"
      health_diet_search[:health] << "vegan"
    end
    if params[:vegetarian] == "1"
      health_diet_search[:health] << "vegetarian"
    end
    if params[:balanced] == "1"
      health_diet_search[:diet] << "balanced"
    end
    if params[:high_protein] == "1"
      health_diet_search[:diet] << "high-protein"
    end
    if params[:low_fat] == "1"
      health_diet_search[:diet] << "low-fat"
    end
    if params[:low_carb] == "1"
      health_diet_search[:diet] << "low-carb"
    end
    return health_diet_search
  end

end
