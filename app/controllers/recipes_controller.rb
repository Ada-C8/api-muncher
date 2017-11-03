class RecipesController < ApplicationController

  def search
  end

  def index
    @search_string = params[:search]
    if @search_string
      return @recipes = EdamamApiWrapper.list_recipes(@search_string)
    elsif @recipes == nil || @recipes == ""
      return @recipes = nil
    end
  end

end
