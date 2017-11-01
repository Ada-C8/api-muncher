class SearchesController < ApplicationController
  def root

  end

  def index
    @recipes = MuncherApiWrapper.search(params[:search_term])["hits"]
  end


  def show
    @results = MuncherApiWrapper.show(params[:uri])
  end

end
