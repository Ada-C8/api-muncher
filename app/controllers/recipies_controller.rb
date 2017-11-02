require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'


class RecipiesController < ApplicationController
  def root
  end # root

  def index
    begin
      @recipies = EdamamApiWrapper.get_recipies(params[:search_term])
      @search_term = params[:search_term]
    rescue EdamamApiWrapper::NoResultsError
      flash[:status] = :failure
      flash[:message] = "Sorry, no recipies match that serch term."
      redirect_to root_path
    rescue EdamamApiWrapper::BadSearchTermError
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't contain numbers or letters!"
      redirect_to root_path
    rescue EdamamApiWrapper::BlankSearchError
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't be blank!"
      redirect_to root_path
    rescue EdamamApiWrapper::ApiError
      "Call to Edamam API failed. Status was #{response.code} #{response.message}"
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
