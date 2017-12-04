require_dependency '../../lib/edamam_api_wrapper'
require_dependency '../../lib/recipe'


class RecipiesController < ApplicationController
  def root
  end # root

  def index
    begin
      # get_recipies will make an API call and then return a list of Recipe instances that match the provided search_term and were generated using the API response data
      results = EdamamApiWrapper.get_recipies(params[:search_term])
      # the search term comes from the form_tag on the root page
      @search_term = params[:search_term]
      # paginate to show 10 recipies per page
      @recipies = results.paginate(:page => params[:page], :per_page => 10)
      return @recipies
      # rescue the error that will be thrown in get_recipies if there are no results for the provided search term
    rescue EdamamApiWrapper::NoResultsError
      flash[:status] = :failure
      flash[:message] = "Sorry, no recipies match that serch term."
      redirect_to root_path
      # rescue the error that will be thrown in get_recipies if the search term contains numbers of symbols
    rescue EdamamApiWrapper::BadSearchTermError
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't contain numbers or letters!"
      redirect_to root_path
      # rescue the error that will be thrown in get_recipies if the search_term is blank
    rescue EdamamApiWrapper::BlankSearchError
      flash[:status] = :failure
      flash[:message] = "Sorry, your search term can't be blank!"
      redirect_to root_path
      # rescue an error in get_recipies where the api call fails, for example if the url is bogus
    rescue EdamamApiWrapper::ApiError
      flash[:status] = :failure
      flash[:message] = "Call to Edamam API failed."
      head :not_found
    end
  end # index

  def show
    # show_recipe will make an api call that returns a single recipe that matches the uri provided. show_recipe returns a single instance of Recipe.
    begin
      @recipe = EdamamApiWrapper.show_recipe(params[:uri])
    # rescue the error thrown when show_recipe is provided an invalid uri
    rescue EdamamApiWrapper::ApiError
      flash[:status] = :failure
      flash[:message] = "Error: you entered an invalid url."
      head :not_found
    end
  end # show
end # RecipiesController
