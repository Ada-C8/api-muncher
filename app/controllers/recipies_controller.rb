require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'


class RecipiesController < ApplicationController
  include Confirmation
  def root
  end # root

  def index
    if empty(params[:search_term])
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't be blank!"
      redirect_to root_path
    elsif symbols(params[:search_term])
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't contain numbers or letters!"
      redirect_to root_path
    else
      @recipies = EdamamApiWrapper.get_recipies(params[:search_term])
      @search_term = params[:search_term]
    end
  end # index

  def show
    # use the uri to do a search for a specific recipe from the api
    # have to encode the uri to get rid of some weird characters in it
    # will have to make another method in EdamamApiWrapper to call here!
    # TODO: redirect to 404 not found if given a bad uri
    begin
      @recipe = EdamamApiWrapper.show_recipe(params[:uri])
    rescue EdamamApiWrapper::ApiError
      flash[:status] = :failure
      flash[:message] = "Error: you entered an invalid url."
      head :not_found
    end
  end # show

end
