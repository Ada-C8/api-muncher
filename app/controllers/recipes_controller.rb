class RecipesController < ApplicationController


  def index
    @search = params[:search]
    @from = (params[:from]) ? params[:from].to_i : 0
    @previous_from = @from - 10
    @from += 10

    if params[:search]
      @recipes = RecipeApiWrapper.search(params[:search], @from)
      if @recipes.nil?
        flash[:status] = "success"
        flash[:message] = "Sorry, Edamam search engine is down."
      end
    else
      @recipes = nil
    end
  end

  def show
    @recipe = RecipeApiWrapper.find(params[:id])


    if @recipe.nil?
      render_404
      return
    end

  end

end
