require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def index
    if params[:search_word]

      @recipes = EdamamApiWrapper.list_recipes(params[:search_word])

      @recipes = WillPaginate::Collection.create(params[:page] || 1, 10, @recipes.length) do |pager|
        pager.replace @recipes
      end
    end
  end

  def show

    @recipe = EdamamApiWrapper.show_recipe(params[:recipe_uri])

  end
end

# Thoughts, do I want to do flash messages for errors and successes?  Perhaps if I have time it may be worth doing.
