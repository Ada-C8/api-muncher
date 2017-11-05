
require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def home
    @recipes = EdamamApiWrapper.search("Thanksgiving").paginate(page: params[:page], per_page: 12)

    if @recipes != []
      message = "We're so happy to have you here at Munchers! Check out our current seasonal favorites below or search for something to munch on"
      status(:success, message)
    end
  end

  def index
    @recipes = EdamamApiWrapper.search(params[:term]).paginate(page: params[:page], per_page: 12)

    if @recipes == []
      message = "Sorry! We couldn't find anything delicious flavours matching #{params[:term]} Please try a different flavor!"
      status(:error, message)
      puts "no recipes found"
    else
      puts "recipes found!"
      message = "Results found for #{params[:term]}"
      status(:success, message)
    end
  end

  def show
    @recipe = EdamamApiWrapper.item_search(params[:uri])

    if @recipe
      message = "#{@recipe.name} found!"
      status(:success, message)
    end

    render_404 unless @recipe
  end

  private

  def status(status, message)
    flash[:status] = status
    flash[:result_text] = message
  end
end
