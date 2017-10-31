class RecipesController < ApplicationController

  def root; end

  def index
    @recipes = EdamamApiWrapper.search(params[:q])
    @search = params[:q].upcase
  end
end
