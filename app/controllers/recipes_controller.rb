require 'recipes_helper'
class RecipesController < ApplicationController
  def show
    @recipe = EdamamApiWrapper.create_recipe(params[:id])
  end

  def search
    if params[:page]
      @page = params[:page].to_i
    else
      @page = 1
    end

    # made in the recipes_helper
    from, to = RecipesHelper.get_from_and_to(@page)

    response = EdamamApiWrapper.search(params[:q], from, to)
    @recipes = EdamamApiWrapper.get_results_from_response(response)

    # pagination and no results
    count = response["count"]
    if count == 0
      flash[:status] = :failure
      flash[:result_text] = "No results to display."
    end

    if @page*10 <= count
      @next_page = "/search?q=#{params[:q]}&page=#{@page+1}"
    end

    if @page > 1
      @previous_page ="/search?q=#{params[:q]}&page=#{@page-1}"
    end

    render search_path
  end
end
