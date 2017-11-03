require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'

class RecipesController < ApplicationController

  def root; end

  def index
    begin
      recipes = EdamamApiWrapper.search(params[:q])
      @search = params[:q].upcase
      if recipes.empty?
        flash[:status] = :failure
        flash[:message] = "Your search for '#{@search}' didn't find anything. Please search again."
        redirect_back(fallback_location: root_path)
      else
        @recipes = recipes.paginate(:page => params[:page], :per_page => 12)
      end

    rescue ApiError => error
      flash[:status] = :failure
      flash[:message] = "#{error}"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    # uri = params[:id]
    # uri.gsub(/%2F/, "/")
    begin
      @recipe = EdamamApiWrapper.find_recipe(params[:id])
    rescue ApiError => error
      puts "IN RESCUE"
      flash[:status] = :failure
      flash[:message] = "#{error}"
      redirect_back(fallback_location: root_path)
    end
  end

end
