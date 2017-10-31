class RecipieController < ApplicationController


  def index
    @recipies = EdemamApiWrapper.list_recipes
  end
end
