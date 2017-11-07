class MainController < ApplicationController
  def index
    @recipes = EdamamApiWrapper.list_recipes("chocolate")
  end

end
