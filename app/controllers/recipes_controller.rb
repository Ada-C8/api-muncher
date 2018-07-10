require_dependency '../../lib/recipe_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

def index

  @search = params[:search]
  current_from = (params[:from]) ? params[:from].to_i : 0
  #if this exists, take it, if not, set it to 0
  @previous_from = current_from - 10
  @from = current_from + 10


  if params[:search]
    @recipes = RecipeApiWrapper.search(params[:search], current_from)
    #If search doesn't return anything it will return an empty array - handle in the view sending a message about that
    if @recipes.nil?
      flash[:status] = "success"
      flash[:message] = "Sorry, Edamam search engine is down."
    end
  else
    @recipes = nil
  end
end

def show
  #if nil:
  if params[:id] == nil
    return render :index, status: :bad_request
  end
  #
  # Another way to write this:
  # render :index, status: :bad_request and return if params[:id].nil?
  ##ONLY can use this and when doing render or redirect and ##
  @recipe = RecipeApiWrapper.find(params[:id])

  if @recipe.nil?
    render_404
    return
  end
end

end
