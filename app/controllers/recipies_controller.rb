class RecipiesController < ApplicationController
  def root
  end # root

  def index
    @recipies = EdamamApiWrapper.get_recipies(params[:search_term])
  end # index

  def show
  end # show
end
