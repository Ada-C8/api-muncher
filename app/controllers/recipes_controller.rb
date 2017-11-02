require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController


  #THIS IS THE SEARCH PAGE WITH QUERY BAR
  def index

  end

  #THIS DISPLAYS THE RESULTS OF WHAT WE FOUND WHEN WE DID THE SEARCH
  def search
    @keywords = params['keywords']
    if @keywords.empty?
      redirect_to root_path
    else
      @recipes = EdamamApiWrapper.list_recipes(@keywords)
    end
  end

  def show
  end

end
