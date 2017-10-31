class RecipeController < ApplicationController

   def root
   end

  def index
    puts "I am in index"
    puts "these are my params #{params}"
    @recipes = EdemamApiWrapper.list_recipes(params[:query])
    #redirect_to :index
  end

  def show
  end


end
