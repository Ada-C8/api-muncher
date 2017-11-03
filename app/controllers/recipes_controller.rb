class RecipesController < ApplicationController

    def home # This will give a search bar to find all recipes
    end

  def index # This will show all the results of the search
    if params[:q] == ""
      flash[:status] = :failure
      flash[:message] = "Please enter a recipe!"
      redirect_back(fallback_location: root_path)
    else
      begin
        recipes = EdamamApiWrapper.search(params[:q])
        @recipes = recipes.paginate(page: params[:page], per_page: 9)
        @search_request = params[:q]
      rescue ApiError => error
        flash[:status] = :failure
        flash[:message] = "#{error}"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def show
    begin
      @recipe = EdamamApiWrapper.find_recipe(params[:id])
    rescue ArgumentError => error
      flash[:status] = :failure
      flash[:message] = "#{error}"
      redirect_back(fallback_location: root_path)
    end
  end

end # Class
