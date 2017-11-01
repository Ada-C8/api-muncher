class RecipeController < ApplicationController

   def root
   end

  def index
    @query = params[:query]
    @recipes = EdemamApiWrapper.list_recipes(@query)
  end

  def show
    puts params
    puts "***********"
    uri = params["uri"]
    puts "I am the uri #{uri}"
    puts "I am a class #{uri.class}"
    @recipe = EdemamApiWrapper.find_a_recipe(uri)
  end


end
