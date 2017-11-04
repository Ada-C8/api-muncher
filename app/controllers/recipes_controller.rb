require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index

    @recipes = EdamamApiWrapper.list_recipes(params[:search_word]).will_paginate(page: params[:page], per_page: 10)

  end

  def show

    @recipe = EdamamApiWrapper.show_recipe(params[:recipe_uri])

  end
end

# Thoughts, do I want to do flash messages for errors and successes?  Perhaps if I have time it may be worth doing.
