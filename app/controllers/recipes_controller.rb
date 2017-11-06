class RecipesController < ApplicationController
  def search
    @homepage = true
  end

  def index
    # if invalid, route back to search render 404
    if params[:query].blank?
      # flash[err] query iz blank
      redirect_to root_path
    else
      # check the string, dsiplay all recipes if valid
      query = params[:query]
      # search using API Wrapper
      @recipes = EdamamApiWrapper.search(query).paginate(page: params[:page], per_page: 10)
      #will_paginate includes a params called page
    end
  end

  def show
    @recipe = EdamamApiWrapper.search(params[:id])[0]
    if @recipe.blank?
      @not_found = true
      render_404
    end
  end
end
